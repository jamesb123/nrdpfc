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
  belongs_to :organism
  belongs_to :project
  has_many :final_mt_dnas, :through => :organism
  authorize_all_for_crud

  class << self
    def table_name_for_project(project_id)
      "mt_dna_final_horizontals_#{project_id.to_i}"
    end
    
    def non_dynamic_columns_names
      %w[id project_id organism_id organism_code]
    end
  end
  
  extend HorizontalClassCreatorSharedMethods
end
