# == Schema Information
#
# Table name: y_chromosome_seqs
#
#  id         :integer(11)   not null, primary key
#  sample_id  :integer(11)   
#  project_id :integer(11)   
#  locus      :string(255)   
#  haplotype  :string(255)   
#  sequence   :text          
#

class YChromosomeSeq < ActiveRecord::Base
  
  belongs_to :project
  belongs_to :sample
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  
  before_create :assign_project_id
  
  def flag_project_for_update
    Project.flag_for_update(self.project_id)
  end

  def to_label 
    "Ex#: #{locus}" 
  end

  def assign_project_id
    self.project_id = current_project_id
  end

end
