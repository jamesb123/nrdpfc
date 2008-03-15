class SamplesController < ApplicationController
  layout "tabs"
  
  active_scaffold :samples do |config|
    config.columns = [:id, :project, :organism_code, :org_sample, :tubebc, :platebc, 
    :plateposition, :field_code, :batch_number, :storage_medium, :country, :province,
    :date_collected, :collected_on_day, :collected_on_month, :collected_on_year, :collected_by, 
    :date_received, :received_by, :receiver_comments, :date_submitted, :submitted_by,  
    :submitter_comments, :latitude, :longitude, :UTM_datum, :locality, 
    :locality_comments, :location_accuracy, :type_lat_long, :storage_building, :storage_room,
    :storage_fridge, :storage_box, :xy_position, :tissue_remaining, :extraction_method, :shippingmaterial, :locality_type, :tissue_type,:security_settings]  
    list.sorting = {:organism_code => 'ASC'}  
    config.create.columns.exclude :id, :security_settings, :project
    config.update.columns.exclude :id, :security_settings, :project
    config.list.columns.exclude  :project
    config.columns[:security_settings].label = "Security"
    config.columns[:extraction_method].form_ui = :select
    config.columns[:shippingmaterial].form_ui = :select
    config.columns[:locality_type].form_ui = :select
    config.columns[:tissue_type].form_ui = :select
        
    config.columns[:organism_code].label = "Org. Code"
    config.columns[:org_sample].label = "Organism Sample# "
    config.columns[:date_collected].label = "Date Collected "
    config.columns[:collected_on_day].label = "Day "
    config.columns[:collected_on_month].label = "Month "
    config.columns[:collected_on_year].label = "Year "
  
    config.columns[:tubebc].label = "Tube Bar Code"
    config.columns[:platebc].label = "Plate Bar Code"
    config.columns[:plateposition].label = "Plate Pos."
    config.columns[:field_code].label = "Field Code"
    config.columns[:batch_number].label = "Batch Number"
    config.columns[:storage_medium].label = "Storage Medium"
    config.columns[:country].label = "Country"
    config.columns[:province].label = "Province"
    config.columns[:date_collected].label = "Date Collected"
    config.columns[:collected_on_day].label = "Day"
    config.columns[:collected_on_month].label = "Month"
    config.columns[:collected_on_year].label = "Year"
    config.columns[:collected_by].label = "Collected By"
    config.columns[:date_received].label = "Date Received"
    config.columns[:received_by].label = "Received by"
    config.columns[:receiver_comments].label = "Receiver Comments"
    config.columns[:date_submitted].label = "Date Submitted"
    config.columns[:submitted_by].label = "Submitted by"
    config.columns[:submitter_comments].label = "Submitter Comments"
    config.columns[:latitude].label = "Latitude"
    config.columns[:longitude].label = "Longitude"
    config.columns[:UTM_datum].label = "UTM"
    config.columns[:locality].label = "Locality"
    config.columns[:locality_comments].label = "Locality Comments"
    config.columns[:location_accuracy].label = "Loc. Accuaracy"
    config.columns[:type_lat_long].label = "Type-Lat-Long"
    config.columns[:storage_building].label = "Building"
    config.columns[:storage_room].label = "Room"
    config.columns[:storage_fridge].label = "Fridge"
    config.columns[:storage_box].label = "Box"
    config.columns[:xy_position].label = "xy pos"
    config.columns[:tissue_remaining].label = "tissue remaining"
  end

  def conditions_for_collection
    ['samples.project_id = (?)', current_project]
  end

end
