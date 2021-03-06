class MicrosatelliteFinalHorizontalsController < ApplicationController
  layout "tabs"
  before_filter :check_current_project

  def self.target_table_name
    :microsatellite_final_horizontals
  end
  
  def custom_reconfiguration(config)
    config.columns = [:project, :organism_code, :raw_data] + @model.dynamic_column_names
    config.list.per_page = 25
  end

public
  include HorizontalSharedMethods
  include GoToOrganismCode::Controller

end
