# == Schema Information
#
# Table name: users
#
#  id                        :integer(11)   not null, primary key
#  project_id                :integer(11)   
#  login                     :string(255)   
#  email                     :string(255)   
#  crypted_password          :string(40)    
#  salt                      :string(40)    
#  created_at                :datetime      
#  updated_at                :datetime      
#  remember_token            :string(255)   
#  remember_token_expires_at :datetime      
#  is_admin                  :boolean(1)    
#

require 'digest/sha1'
class User < ActiveRecord::Base
  belongs_to :current_project, :class_name => 'Project', :foreign_key => "project_id"  
  has_many :security_settings
  has_many :projects
  
  before_save :set_project, :check_for_duplicate_admins

  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  
  def to_label
    "#{login}"
  end
  
  
  def check_for_duplicate_admins
    return true # DLR: Now, allowing multiple admins, as per 4/10/8 conversation
    # DLR: No longer using is_admin
    # return true if ! self.is_admin
    #! User.find(:first, :conditions => {:is_admin => true})
  end
  
  # Requires that a project always be set for a user, 
  # even if it's a Default project with no data or permissions.
  def set_project
    self.project_id ||= Project.find_or_create_by_name('Default')
  end
  
  # We're experimenting with a simpler idea: all project managers are admins
  def is_project_manager?
    project_owners = Project.find(:all).map{|project| project.owner}.uniq
    project_owners.include?(current_user)
  end
  
  # Count all projects with access level above 0 (0 is NO ACCESS)
  # If there is one, then you do.
  def has_access_to_active_projects?
    self.security_settings.inject(0){|sum, ss| sum += 1 if ss.level > 0} > 0
  end
  
  def authorized_security_for?(project, minimum_security_level)
   # DLR: No longer using is_admin
   #return true if current_user.is_admin
   return false if !project
    
   current_user == project.owner || current_user.security_settings.detect {|setting| setting.project == project && setting.level >= minimum_security_level}
  end

  def authorized_as_project_manager?
    self.is_project_manager?
  end

  def authorization_display_for(project)
    if !project
      SecuritySetting.new(:level => SecuritySetting::NO_ACCESS).to_label
    elsif project.owner == current_user
      SecuritySetting.new(:level => SecuritySetting::READ_WRITE_DELETE).to_label      
    else
      setting = project.security_settings.find(:first, :conditions => ["user_id = ?", current_user.id])
      if setting
        "#{setting.to_label}"
      else
        SecuritySetting.new(:level => SecuritySetting::NO_ACCESS).to_label
      end
    end
  end
  
  def self.find_everybody_but_me
    User.find(:all, :conditions => ['id <> ?', current_user.id])    
  end
  
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
logger.debug("!!!!!!!!!! login == #{login}, password = #{password}")
    u = find_by_login(login) # need to get the salt
logger.debug("!!!!!!!!!! user  == #{u.inspect}")
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  def current_project_authorized?
    true
  end
  
  def authorized_for_create?
    true
  end
    
  def authorized_for_update?
    true
  end
  
  def authorized_for_read?
    true
  end

  def authorized_for_destroy?
    true
  end

protected
  # before filter 
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
end
