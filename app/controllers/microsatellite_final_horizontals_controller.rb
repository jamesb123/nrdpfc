class MicrosatelliteFinalHorizontalsController < ApplicationController
  layout "tabs"
  
  def self.target_table_name
    :microsatellite_final_horizontals
  end
  
  def custom_reconfiguration(config)
    config.list.columns = [:project, :organism_code, :raw_data] + @model.dynamic_column_names
    @model.dynamic_column_names.each{|column_name|
      config.columns[column_name].form_ui = :ajax_link
    }
    #config.action_links.add('go_to', :label => "Go To...", :page => true) 
    
  end
  
public
  include HorizontalSharedMethods
end
