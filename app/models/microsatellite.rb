# == Schema Information
#
# Table name: microsatellites
#
#  id          :integer(11)   not null, primary key
#  sample_id   :integer(11)   
#  project_id  :integer(11)   
#  locus       :string(255)   
#  allele1     :string(255)   
#  allele2     :string(255)   
#  gel         :string(255)   
#  well        :string(255)   
#  finalResult :boolean(1)    
#

class Microsatellite < ActiveRecord::Base
  belongs_to :sample
  belongs_to :project
  
  before_create :assign_project_id
  after_save :flag_project_for_update
  
  def assign_project_id
    self.project_id = current_user.current_project.id
  end
  
  
  def to_label
   "#{self.locus} #{allele1} - #{allele2}"
  end

  def security_settings
    current_user.authorization_display_for project
  end
  
  def flag_project_for_update
    Project.flag_for_update(self.project_id)
  end
  
  def authorized_for_create?
    true
  end
  
  def authorized_for_update?
    # this method gets called for rows and for Class level questions, so this check returns true at the class level
    return true unless existing_record_check?
    
    current_user.authorized_security_for?(project, SecuritySetting::READ_WRITE)
  end
  
  def authorized_for_read?
    return true unless existing_record_check?

    current_user.authorized_security_for?(project, SecuritySetting::READ_ONLY)
  end

  def authorized_for_destroy?
    return true unless existing_record_check?

    current_user.authorized_security_for?(project, SecuritySetting::READ_WRITE_DELETE)
  end
  
end
