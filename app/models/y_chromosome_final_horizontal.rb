# == Schema Information
#
# Table name: y_chromosome_final_horizontals
#
#  id                :integer(11)   not null, primary key
#  project_id        :integer(11)   
#  organism_id       :integer(11)   
#  organism_code     :integer(11)   
#  haplotype         :integer(11)   
#  extraction_number :integer(11)   
#  created_at        :datetime      
#  updated_at        :datetime      
#

class YChromosomeFinalHorizontal < ActiveRecord::Base
end
