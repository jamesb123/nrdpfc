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
  
  # belongs_to :organism, :through => :samples
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased

  before_create :assign_project_id
  before_save :assign_approval

  def assign_approval
    if ! current_user.data_entry_only
       self.approved = true
    end
  end 

  def to_label 
     "#{self.id}" 
  end

  def approved_authorized?
    ! current_user.data_entry_only    
  end
  
  def approved_authorized_for_update?
    current_user.is_admin    
  end

  def approved_authorized_for_create?
    current_user.is_admin    
  end

  def assign_project_id
    self.project_id = (current_project_id rescue nil)
  end
  
end
