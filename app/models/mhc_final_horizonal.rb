# == Schema Information
#
# Table name: mhc_final_horizonals
#
#  id            :integer(11)   not null, primary key
#  project_id    :integer(11)   
#  organism_id   :integer(11)   
#  organism_code :integer(11)   
#  allelea       :integer(11)   
#  alleleb       :integer(11)   
#  created_at    :datetime      
#  updated_at    :datetime      
#

class MhcFinalHorizonal < ActiveRecord::Base
end
