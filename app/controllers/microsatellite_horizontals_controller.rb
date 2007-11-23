class MicrosatelliteHorizontalsController < ApplicationController
  layout "tabs"
  before_filter :set_to_project, :except => [:not_compiled]
  
  active_scaffold :microsatellite_horizontals do |config|
    # perform basic configuration
  end
  
  
  def not_compiled
    @project = current_project
    @model = model_for_current_project
    redirect_to :action => "index" if @model
  end
  
  def set_to_project
    @project_id = current_project.id
    @model = model_for_current_project
    
    if @model == nil
      redirect_to(:action => "not_compiled")
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
protected
  def model_for_current_project
    MicrosatelliteHorizontal.model_for_project(current_project)

  end
end
