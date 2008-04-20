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
  for table_name in Sample::RESULT_TABLES
    has_many table_name.to_sym
  end
  
  has_many :organisms, :order => "organism_code"
  has_many :samples
  has_many :users
  has_many :sample_non_tissues
  has_many :mt_dna_seqs
  has_many :security_settings
  has_many :y_chromosome_seqs
  has_many :security_settings
  has_many :microsatellite_horizontals
  has_many :mt_dna_final_horizontals
  has_many :y_chromosome_final_horizontals
  has_many :mhc_final_horizontals
  has_many :gender_final_horizontals
  has_many :dna_results
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  has_many :mhc_seqs
  
  before_create :assign_project_owner
  after_save :assign_default_project

  def assign_project_owner
    return true if self.name == "Default"  
    begin
      self.user_id ||= current_user.id
    rescue
      raise "Must be logged in to create a project"
    end
  end

  # if this is the first project created for this user
  # then make it their current (default) project
  def assign_default_project  
    if current_user 
      current_project = self
      current_user.save
    end
  end

  #everybody can creat projects
  def authorized_for_create?
    #true
    current_user.is_admin
  end

  def authorized_for_update?
    current_user.is_admin
    # this method gets called for rows and for Class level questions, so this check returns true at the class level
    #    return true unless existing_record_check?
    #    current_user.authorized_security_for?(self, SecuritySetting::READ_WRITE)
  end
  
  def authorized_for_read?
    return true # unless existing_record_check?
    # return true if current_user.authorized_as_project_manager?
    #    current_user.authorized_security_for?(self, SecuritySetting::READ_ONLY)
  end

  def authorized_for_destroy?
    current_user.is_admin
    #    return true unless existing_record_check?
    #    current_user.authorized_security_for?(self, SecuritySetting::READ_WRITE_DELETE)
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
    current_user && current_user.accessible_projects
  end
end
