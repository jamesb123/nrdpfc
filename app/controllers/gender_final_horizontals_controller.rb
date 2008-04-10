class GenderFinalHorizontalsController < ApplicationController
  layout "tabs"
  
  def self.target_table_name
    :gender_final_horizontals
  end
  
  def custom_reconfiguration(config)
    config.columns = [:project, :sample]
    config.list.columns = [:project, :organism_code, :raw_data] + @model.dynamic_column_names
    #config.action_links.add('go_to', :label => "Go To...", :page => true) 
  end
  
public
  include HorizontalSharedMethods
end
