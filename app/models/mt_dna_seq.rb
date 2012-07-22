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

  extend Exportables::ExportableModel
  include ProjectRelations
  include SecuritySets::ProjectBased

  belongs_to :locu
  belongs_to :project
  belongs_to :mt_dna
  
  def to_label
    "#{locus}" 
  end

end
