class MicrosatelliteHorizontalsController < ApplicationController
  layout "tabs"
  before_filter :check_current_project

  def self.target_table_name
    :microsatellite_horizontals
  end
  
  def custom_reconfiguration(config)
    config.columns = [:sample, :organism_index, :sample_id, :raw_data] + model_for_current_project.dynamic_column_names

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}
    config.columns[:sample].label = "Organism"
    config.columns[:sample_id].label = "Sample ID"
    config.columns[:organism_index].label = "Index"
    config.list.per_page = 25

    config.columns[:sample].search_sql = "organisms.organism_code"
    config.search.columns = [ :sample ]
  end
  
  


def show
  
end

  # recompile_status will fire an ajax request to recompile
  def recompile_status
    find_project
  end
  
  def recompile
    find_project
    Compiler.compile_project(@project)
    @project.reload
  end


  
public
  include HorizontalSharedMethods
  include GoToOrganismCode::Controller
protected
  def find_project
#    @project = Project.find(params[:id])
    @project = Project.find(current_project.id)
  end
end
  

