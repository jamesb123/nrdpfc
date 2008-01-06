# == Schema Information
#
# Table name: organisms
#
#  id            :integer(11)   not null, primary key
#  project_id    :integer(11)   
#  organism_code :string(255)   
#  comment       :string(255)   
#

class Organism < ActiveRecord::Base

  has_many_dynamic_attributes :scoped_by => 'Project'
  
  belongs_to :project
  has_many :samples
  
  for table_name in Sample::RESULT_TABLES
    has_many table_name, :through => :samples 
    has_many "final_#{table_name}", :through => :samples
  end
  
  has_many :sample_non_tissues
  
  def to_label
   "#{organism_code}" 
  end

  def security_settings
    current_user.authorization_display_for project
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
