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
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  include ProjectRelations

  def to_label 
    "Ex#: #{locus}" 
  end

end
