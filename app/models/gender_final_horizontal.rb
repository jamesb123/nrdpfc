# == Schema Information
#
# Table name: gender_final_horizontals
#
#  id            :integer(11)   not null, primary key
#  project_id    :integer(11)   
#  organism_id   :integer(11)   
#  organism_code :string(255)   
#  gender        :integer(11)   
#

class GenderFinalHorizontal < ActiveRecord::Base
  belongs_to :organism
  belongs_to :project
  has_many :final_genders, :through => :organism
  
  authorize_all_for_crud
  
  extend Exportables::HorizontalExportableModel
  
  class << self
    def table_name_for_project(project_id)
      "gender_final_horizontals_#{project_id.to_i}"
    end
    
    def non_dynamic_columns_names
      %w[id project_id organism_id organism_code]
    end
  end
  
  extend HorizontalClassCreatorSharedMethods
  extend GoToOrganismCode::Model
end
