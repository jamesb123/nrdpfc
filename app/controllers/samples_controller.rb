class SamplesController < ApplicationController
  layout "tabs"

  record_select :per_page => 20,
                :search_on => ['organisms.organism_code'],
                :order_by => 'samples.id'

  def record_select_includes; :organism; end

  def record_select_conditions_from_controller
    [ 'samples.project_id = ?', current_project_id ]
  end
  
  include GoToOrganismCode::Controller

  active_scaffold :samples do |config|
    config.columns = [:id, :organism, :organism_id, :organism_index, :project, :tubebc, :platebc, 
    :plateposition, :field_code, :batch_number, :shippingmaterial, :country, :province,
    :date_collected, :collected_on_year, :collected_on_month,  :collected_on_day, :collected_by, 
    :date_received, :received_by, :receiver_comments, :date_submitted, :submitted_by,  
    :submitter_comments, :type_lat_long, :latitude, :longitude, :UTM_datum, :locality, 
    :locality_comments, :location_accuracy, :storage_building, :storage_room,
    :storage_fridge, :storage_box, :xy_position, :tissue_remaining, :extraction_method, :storage_medium, :locality_type, :tissue_type,:security_settings]  
    
    # search associated organism colum
    config.columns[:organism].search_sql = 'organisms.organism_code'
    config.search.columns << :organism
     
    config.columns[:organism].sort_by :sql => "organisms.organism_code"
    config.create.columns.exclude :id, :security_settings, :project, :date_submitted, :sample_id, :organism_id
    config.update.columns.exclude :id, :security_settings, :project, :date_submitted, :sample_id, :organism_id
    config.list.columns.exclude  :project
    
    config.nested.add_link("DNA", [:dna_results])
    config.nested.add_link("mtDNA", [:mt_dnas])
    config.nested.add_link("Genders", [:genders])
    config.nested.add_link("MS", [:microsatellites])
    config.nested.add_link("MHC", [:mhcs])
    config.nested.add_link("Y", [:y_chromosomes])
    
    config.columns[:id].label = "Sample ID"
    config.columns[:organism].label = "Organism Code"
    config.columns[:organism_id].label = "Organism ID"
    config.columns[:organism_index].label = "Organism Sample Index"
    config.columns[:security_settings].label = "Security"
    
    config.columns[:extraction_method].form_ui = :select
    config.columns[:shippingmaterial].form_ui = :select
    config.columns[:locality_type].form_ui = :select
    config.columns[:tissue_type].form_ui = :select
    config.columns[:organism].form_ui = :select
    
    config.columns[:date_collected].label = "Date Collected "
    config.columns[:collected_on_day].label = "Collected Day "
    config.columns[:collected_on_month].label = "Collected Month "
    config.columns[:collected_on_year].label = "Collected Year "
  
    config.columns[:shippingmaterial].label = "Shipping Medium"
    config.columns[:tubebc].label = "Sample Bar Code"
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
    
    config.columns[:id].tooltip = "This is the unique identifier given to each sample by the database It is based on the ENTIRE database, not just the samples within your project."
    
    config.columns[:organism].tooltip = "This is the unique identifier given to<br/>
    each sample by the database.<br/>
    It is based on the ENTIRE database,<br/>
    not just the samples within your project."
   
    config.columns[:organism_id].tooltip = "This is the unique identifier, given by you,<br/>
    to the individuals/organisms within your project.<br/> 
    You need to fill in this field as appropriate for your project."
  
    config.columns[:plateposition].tooltip = "This is the weel number for the sample on the plate<br/>
     (e.g. A01, H12, etc."

    config.columns[:field_code].tooltip = "This is the unique identifier given to the sample by the people<br/>
    who collected the sample."
  
    config.columns[:batch_number].tooltip = "If you are processing samples in batches,<br/>
    then this is the batch number in which the sample was entered into the database."
      
    config.columns[:date_collected].tooltip = <<-END
      If you know the exact date on which the sample was collected,<br/>
      then you should enter that information here.<br/>
      If you do not have the complete date,<br/>
      then use the independent fields in the next columns.
    END
    config.columns[:collected_on_year].tooltip = <<-END
      If you don't know the exact date on which the sample was collected, but you know the year, enter that here.
    END
    config.columns[:collected_on_month].tooltip = <<-END
      If you don't know the exact date on which the sample was collected, but you know the month, enter that here.
    END
    config.columns[:collected_on_day].tooltip = <<-END
      If you don't know the exact date on which the sample was collected, but you know the day, enter that here.
    END
    
  
  end
  
  def conditions_for_collection
    ['samples.project_id = (?)', current_project_id ]
  end
  
end
