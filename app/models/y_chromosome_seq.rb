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
  belongs_to :sample
  
  extend Exportables::ExportableModel
end
