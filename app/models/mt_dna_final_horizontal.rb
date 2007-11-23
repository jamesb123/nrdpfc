# == Schema Information
#
# Table name: mt_dna_final_horizontals
#
#  id            :integer(11)   not null, primary key
#  project_id    :integer(11)   
#  organism_id   :integer(11)   
#  organism_code :integer(11)   
#  haplotype     :integer(11)   
#  created_at    :datetime      
#  updated_at    :datetime      
#

class MtDnaFinalHorizontal < ActiveRecord::Base
end
