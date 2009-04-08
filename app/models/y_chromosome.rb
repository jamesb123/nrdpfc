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
  belongs_to :locu
  
  before_create :assign_project_id
  after_save :flag_project_for_update
  
  attr_accessor :y_chromosome
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased

  def conditions_for_collection
    ['samples.project_id = (?)', current_project_id ]
  end
  
  def flag_project_for_update
    Project.flag_for_update(self.project_id)
  end

  def assign_project_id
    self.project_id = current_project_id
  end
  
  def to_label 
    "locus" 
  end
  
end
