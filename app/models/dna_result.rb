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
  belongs_to :extraction_method
  belongs_to :sample
  # belongs_to :organism, :through => :samples
 
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  include ProjectRelations
  include ApprovalModelHelpers

  # after_create :assign_extraction_date
#  after_initialize :init
#  def init
#    self.extraction_date = nil
#  end
  
#  def assign_extraction_date
#    self.extraction_date = nil
#  end

  def to_label 
     "#{self.id}" 
  end
end
