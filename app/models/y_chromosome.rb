# == Schema Information
#
# Table name: y_chromosomes
#
#  id          :integer(11)   not null, primary key
#  sample_id   :integer(11)   
#  project_id  :integer(11)   
#  locus       :string(255)   
#  haplotype   :string(255)   
#  gelNum      :string(255)   
#  wellNum     :string(255)   
#  finalResult :boolean(1)    
#

class YChromosome < ActiveRecord::Base
  belongs_to :sample
  belongs_to :project
  after_save :flag_project_for_update
  
  attr_accessor :y_chromosome
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  
  
  def flag_project_for_update
    Project.flag_for_update(self.project_id)
  end

  def assign_project_id
    self.project_id = current_project_id
  end
  
  def to_label 
    "locus" 
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
