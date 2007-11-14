# == Schema Information
#
# Table name: sample_non_tissues
#
#  id                 :integer(11)   not null, primary key
#  organism_id        :integer(11)   
#  project_id         :integer(11)   
#  field_code         :string(255)   
#  prov               :string(255)   
#  country            :string(255)   
#  date_collected     :date          
#  collected_by       :string(255)   
#  submitted_by       :string(255)   
#  date_submitted     :date          
#  submitter_comments :text          
#  received_by        :string(255)   
#  date_received      :date          
#  receiver_comments  :text          
#  latitude           :float         
#  longitude          :float         
#  UTM_datum          :float         
#  locality           :string(255)   
#  locality_type      :string(255)   
#  locality_comments  :string(255)   
#  location_accuracy  :string(255)   
#  type_lat_long      :string(255)   
#

class SampleNonTissue < ActiveRecord::Base

  has_many_dynamic_attributes :scoped_by => 'Project'

  belongs_to :organism
  belongs_to :project

  before_create :assign_project_id

  def assign_project_id
    self.project_id = current_user.current_project.id
  end
  
  def to_label 
    "#{id}" 
  end
  
  def security_settings
    current_user.authorization_display_for self.project
  end

  def authorized_for_create?
    true
  end
  
  def authorized_for_update?
    # this method gets called for rows and for Class level questions, so this check returns true at the class level
    return true unless existing_record_check?
    current_user.authorized_security_for?(self.project, SecuritySetting::READ_WRITE)
  end
  
  def authorized_for_read?
    return true unless existing_record_check?
    current_user.authorized_security_for?(self.project, SecuritySetting::READ_ONLY)
  end

  def authorized_for_destroy?
    return true unless existing_record_check?
    current_user.authorized_security_for?(self.project, SecuritySetting::READ_WRITE_DELETE)
  end
     
end
