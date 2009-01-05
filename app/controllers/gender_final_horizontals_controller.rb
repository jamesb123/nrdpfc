class GenderFinalHorizontalsController < ApplicationController
  layout "tabs"
  
  def self.target_table_name
    :gender_final_horizontals
  end
  
  def custom_reconfiguration(config)
    config.columns = [:project, :organism_code, :raw_data] + @model.dynamic_column_names
  end
  
public
  include HorizontalSharedMethods
  include GoToOrganismCode::Controller
  
end
