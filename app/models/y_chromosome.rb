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
  belongs_to :locu
  belongs_to :sample
  belongs_to :project
  has_many :y_chromosome_seqs
  
  attr_accessor :y_chromosome
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  include ProjectRelations
  include ApprovalModelHelpers

  def to_label 
    "locus" 
  end
end
