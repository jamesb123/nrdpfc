class MicrosatelliteHorizontalsController < ApplicationController
  layout "tabs"
  before_filter :set_to_project, :except => :index
  
  active_scaffold :microsatellite_horizontals do |config|
    # perform basic configuration
  end
  
  def index
    
  end
  
  def set_to_project
    @project_id = params[:project_id]
    @model = MicrosatelliteHorizontal.model_for_project(@project_id)
    
    if @model == nil
      flash[:notice] = "The specified project has not been compiled."
      redirect_to(:action => "index")
      return false
    end
    
    as_reconfigure(:microsatellite_horizontals, @model) {|config| 
      config.columns = [:project, :sample]
      config.list.columns = [:project, :sample, :organism_code, :org_sample, :raw_data] + @model.dynamic_column_names
      @model.dynamic_column_names.each{|column_name|
        config.columns[column_name].form_ui = :ajax_link
      }
    }
    true
  end
  
  def list_authorized?
    true
  end
end
