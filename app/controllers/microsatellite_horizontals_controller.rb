class MicrosatelliteHorizontalsController < ApplicationController
  layout "tabs"
  
  def self.target_table_name
    :microsatellite_horizontals
  end
  
  def custom_reconfiguration(config)
    config.columns = [:sample, :organism_index, :raw_data] + model_for_current_project.dynamic_column_names

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}
    config.columns[:sample].label = "Organism Code (Sample ID)"

    config.columns[:sample].search_sql = "organisms.organism_code"
    config.search.columns = [ :sample ]
  end
  
public
  include HorizontalSharedMethods
  include GoToOrganismCode::Controller
  
end
