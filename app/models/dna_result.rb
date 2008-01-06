# == Schema Information
#
# Table name: dna_results
#
#  id                 :integer(11)   not null, primary key
#  sample_id          :integer(11)   
#  project_id         :integer(11)   
#  prep_number        :integer(11)   
#  extraction_number  :integer(11)   
#  barcode            :string(255)   
#  plate              :string(255)   
#  position           :string(255)   
#  extraction_method  :string(255)   
#  extraction_date    :date          
#  extractor          :string(255)   
#  extractor_comments :string(255)   
#  fluoro_conc        :float         
#  functional_conc    :float         
#  pico_green_conc    :float         
#  storage_building   :string(255)   
#  storage_room       :string(255)   
#  storage_freezer    :string(255)   
#  storage_box        :string(255)   
#  xy_position        :string(255)   
#  dna_remaining      :boolean(1)    
#

class DnaResult < ActiveRecord::Base
  belongs_to :sample
  belongs_to :project
  
  extend Exportables::ExportableModel
  
  def to_label 
    "Ex#: #{prep_number}" 
  end

  before_create :assign_project_id

  def assign_project_id
    self.project_id = (current_user.current_project.id rescue nil)
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
