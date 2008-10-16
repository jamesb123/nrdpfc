# == Schema Information
#
# Table name: mt_dna_seqs
#
#  id         :integer(11)   not null, primary key
#  project_id :integer(11)   
#  locus      :string(255)   
#  haplotype  :string(255)   
#  sequence   :text          
#

class MtDnaSeq < ActiveRecord::Base
  belongs_to :project
  
  before_create :assign_project_id
  # after_save :flag_project_for_update
  
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  
  def assign_project_id
    self.project_id = current_project_id
  end
  
  def to_label
    "#{locus}" 
  end

end
