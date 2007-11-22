# == Schema Information
#
# Table name: projects
#
#  id                 :integer(11)   not null, primary key
#  name               :string(255)   
#  code               :string(255)   
#  description        :string(255)   
#  user_id            :integer(11)   
#  recompile_required :boolean(1)    
#

class Project < ActiveRecord::Base

  has_many :genders
  has_many :organisms
  has_many :samples
  has_many :users
  has_many :sample_non_tissues
  has_many :mhcs
  has_many :mt_dna_seqs
  has_many :microsatellites
  has_many :security_settings
  has_many :y_chromosomes
  has_many :security_settings
  
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  
  before_create :assign_project_owner
  after_save :assign_default_project

  def assign_project_owner  
    self.user_id = current_user.id
  end

  # if this is the first project created for this user
  # then make it their current (default) project
  def assign_default_project  
    return true if current_user.nil?
#      if current_user.projects.size == 1 || current_user.current_project.nil?
      current_user.current_project = self
      current_user.save
#      end
  end

  #everybody can creat projects
  def authorized_for_create?
    true
  end

  def authorized_for_update?
    # this method gets called for rows and for Class level questions, so this check returns true at the class level
    return true unless existing_record_check?
    current_user.authorized_security_for?(self, SecuritySetting::READ_WRITE)
  end
  
  def authorized_for_read?
    return true unless existing_record_check?
    current_user.authorized_security_for?(self, SecuritySetting::READ_ONLY)
  end

  def authorized_for_destroy?
    return true unless existing_record_check?
    current_user.authorized_security_for?(self, SecuritySetting::READ_WRITE_DELETE)
  end
  
  def security_setting
    current_user.authorization_display_for(self)
  end
  
  def self.flag_for_update(project)
    project = Project.find(project) unless project.is_a?(ActiveRecord::Base)
    project.recompile_required = true
    project.save(false)
  end
  
  def self.current_users_accessible_projects
    Project.find(:all).select{|p| p.authorized_for_read?}
  end
end
