class MicrosatelliteHorizontalsController < ApplicationController
  layout "tabs"
  
  def self.target_table_name
    :microsatellite_horizontals
  end
  
  def custom_reconfiguration(config)
    config.columns = [:project, :sample]
    config.list.columns = [:sample, :organism_index, :raw_data] + model_for_current_project.dynamic_column_names
    model_for_current_project.dynamic_column_names.each{|column_name|
      config.columns[column_name].form_ui = :ajax_link
    }
    #config.action_links.add('go_to', :label => "Go To...", :page => true) 
    
  end
  
public
  include HorizontalSharedMethods
end
