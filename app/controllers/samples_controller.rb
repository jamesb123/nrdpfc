class SamplesController < ApplicationController
  layout "tabs"
  include GoToOrganismCode::Controller


  SAMPLES_COLUMNS = [:id, :organism_id, :organism, :organism_index, :sample_bc, :field_code, :country, :province, 
    :locality, :locality_type, :locality_type_text, :locality_comments, :location_accuracy,  
    :latitude, :longitude, :coordinate_system,  :location_measurement_method,  :type_lat_long,  
    :date_collected,  :collected_on_day,  :collected_on_month, :collected_on_year, :collected_by, 
    :date_received, :received_by, :receiver_comments, :date_submitted, :submitted_by,  
    :submitter_comments, :tissue_type, :extraction_method, :shippingmaterial,
    :platebc, :plateposition, :batch_number, 
    :storage_medium, :storage_building, :storage_room, :storage_fridge, :storage_box,
    :xy_position, :tissue_remaining,  :security_settings,:project,:approved]
    

#  include ActionView::Helpers::FormOptionsHelper
#  protect_from_forgery :except => [:samples_field_code] 
  
  record_select :per_page => 20,
                :search_on => ['organisms.organism_code'],
                :order_by => 'samples.id'

  def record_select_includes; :organism; end


  include GoToOrganismCode::Controller  

  active_scaffold :samples do |config|
    config.columns = SAMPLES_COLUMNS 

    # search associated organism colum
    config.columns[:organism].search_sql = 'organisms.organism_code'
    config.search.columns << :organism
     
    config.columns[:organism].sort_by :sql => "organisms.organism_code"

    config.create.columns.exclude :locality_type_text, :id, :security_settings, :project, :date_submitted, :sample_id, :organism_id
    config.update.columns.exclude :locality_type_text, :id, :security_settings, :project, :date_submitted, :sample_id, :organism_id
    config.list.columns.exclude  :project, :type_lat_long, :locality_type
    
    config.list.per_page = 25
    # The split tables can't update after an edit,
    # so we just have to do the edit in a new page
    config.update.link.page = true
    config.create.link.page = true

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
    config.columns[:approved].label = "Approved"
    config.columns[:approved].form_ui = :checkbox
    config.columns[:extraction_method].form_ui = :select
    config.columns[:shippingmaterial].form_ui = :select
    config.columns[:storage_medium].form_ui = :select
    config.columns[:locality_type].form_ui = :select
    config.columns[:tissue_type].form_ui = :select
    config.columns[:organism].form_ui = :select
    
    config.columns[:date_collected].label = "Date Collected "
    config.columns[:collected_on_day].label = "Collected Day "
    config.columns[:collected_on_month].label = "Collected Month "
    config.columns[:collected_on_year].label = "Collected Year "
  
    config.columns[:shippingmaterial].label = "Shipping Medium"
    config.columns[:sample_bc].label = "Sample Bar Code"
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
    config.columns[:coordinate_system].label = "Coordinate System"
    config.columns[:locality_type_text].label = "Locality Type"
    config.columns[:locality].label = "Locality"
    config.columns[:locality_comments].label = "Locality Comments"
    config.columns[:location_accuracy].label = "Loc. Accuaracy"
    config.columns[:location_measurement_method].label = "Location Measurement Method"
    config.columns[:type_lat_long].label = "Type-Lat-Long"
    config.columns[:storage_building].label = "Building"
    config.columns[:storage_room].label = "Room"
    config.columns[:storage_fridge].label = "Fridge"
    config.columns[:storage_box].label = "Box"
    config.columns[:xy_position].label = "xy pos"
    config.columns[:tissue_remaining].label = "tissue remaining"
    
    config.columns[:id].tooltip = <<-END
    This is the unique identifier <br>
    given to each sample by the database. <br>
    It is based on the ENTIRE database, <br>
    not just the samples within your project.
    END
    
    config.columns[:organism_id].tooltip = <<-END
    This is the unique identifier given to<br>
    each sample by the database.<br>
    It is based on the ENTIRE database,<br>
    not just the samples within your project.
    END
   
    config.columns[:organism].tooltip = <<-END
    This is the unique identifier, given by you,<br>
    to the individuals/organisms within your project.<br> 
    You need to fill in this field as appropriate for your project.
    END
  
    config.columns[:plateposition].tooltip = <<-END
    This is the well number <br>
    for sample on the plate<br>
    (e.g. A01, H12, etc.
    END

    config.columns[:batch_number].tooltip = <<-END
    If you are processing samples in batches,<br>
    then this is the batch number<br>
    in which the sample in the database.
    END
      
    config.columns[:date_collected].tooltip = <<-END
    If you know the exact date on which the sample was collected,<br>
    then you should enter that information here.<br>
    If you do not have the complete date,<br>
    then use the independent fields in the next columns.
    END
    config.columns[:collected_on_year].tooltip = <<-END
    If you don't know the exact date<br>
    on which the sample was collected,<br>
    but you know the year, enter that here.
    END
    config.columns[:collected_on_month].tooltip = <<-END
    If you don't know the exact date<br>
    on which the sample was collected,<br>
    but you know the month, enter that here.
    END
    config.columns[:collected_on_day].tooltip = <<-END
    If you don't know the exact date<br>
    on which the sample was collected,<br>
    but you know the day, enter that here.
    END
    
    config.columns[:collected_by].tooltip = <<-END
    The identity of the person <br>
    or research team who collected the sample.
    END
    
    config.columns[:date_received].tooltip = <<-END
    The date that the sample<br>
    was received at the laboratory.
    END
  
    config.columns[:received_by].tooltip = <<-END
    The person in the laboratory who received the sample
    END
    
    config.columns[:receiver_comments].tooltip = <<-END
    receiver comments
    END
    
    config.columns[:date_submitted].tooltip = <<-END
    The date that the sample was submitted to the database
    END
    
    config.columns[:submitted_by].tooltip = <<-END
    The person who entered the sample data into the database
    END
    
    config.columns[:submitter_comments].tooltip = <<-END
    Any comments that the submitter has<br>
    regarding the sample<br>
    (e.g. lid was half open and liquid was oozing out).
    END
    
    config.columns[:latitude].tooltip = <<-END
    The latitude at which the sample was collected<br>
    In decimal degrees or in degrees,<br>
    but you need to specify which one in the<br>
    Type-Lat-Long field.  Can also be the<br>
    Northing/Southing number for coordinate system,<br>
    but you will need to specify your projection in the "Coordinate System" field.
    END
  
    config.columns[:longitude].tooltip = <<-END
    The longitude at which the sample was collected<br>
    In decimal degrees or in degrees,<br>
    but you need to specify which one in the<br>
    Type-Lat-Long field.  Can also be the<br>
    Easting/Westing number if you have Coordinate System data,<br>
    but you will need to specify your projection in the "Coordinate System" field.
    END

    config.columns[:coordinate_system].tooltip = <<-END
    If you have Coordinate System location data,<br>
    then this field should contain the projection<br>
    in which your location data are formatted.<br>
    If you have Coordinate System coordinates, indicate the zone.<br>
    If not, indicate the Datum used.
    END

    config.columns[:locality_type].tooltip = <<-END
    This is a pull-down menu for different<br>
    locality types (e.g. National Park, Provincial Park, etc…).
    END
    
    config.columns[:locality_comments].tooltip = <<-END
    A field to describe in what locality the sample was collected<br>
    (e.g. Algonquin if the sample was collected in Alonquin Provincial Park).  
    END
    
    config.columns[:location_accuracy].tooltip = <<-END
    Describe how accurate your location data are,<br>
    if applicable.  For example,<br>
    given location +/- 10 m, etc…
    END
    
    config.columns[:type_lat_long].tooltip = <<-END
    Latitude and longitude data<br>
    are in degrees or decimal degrees.
    END
    config.columns[:storage_building].tooltip = <<-END
    What building is the sample stored in?
    END
    config.columns[:storage_room].tooltip = <<-END
    What room is the sample stored in?
    END
    config.columns[:storage_fridge].tooltip = <<-END
    What refrigerator is the sample stored in?
    END
    config.columns[:storage_box].tooltip = <<-END
    The box number/label that the sample is stored in
    END
    
    config.columns[:xy_position].tooltip = <<-END
    The position in the box where the sample is located (e.g. A10, B02, etc…).
    END
    
    config.columns[:xy_position].tooltip = <<-END
    The position in the box where the sample is located (e.g. A10, B02, etc…).
    END

    config.columns[:tissue_remaining].tooltip = <<-END
    Is there any tissue remaining?
    END

    config.columns[:extraction_method].tooltip = <<-END
    What extraction method did you use to obtain DNA from this sample.
    END

    config.columns[:storage_medium].tooltip = <<-END
    What is the medium that the sample is stored in
    END
    
    config.columns[:tissue_type].tooltip = <<-END
    What is the type of tissue of this sample?
    END

  end

  def unapproved
    @condition = ['samples.project_id = (?) and samples.approved = (?)', current_project_id, false ]        
    index
  end

  def approved
    @condition = ['samples.project_id = (?) and samples.approved = (?)', current_project_id, true ]        
    index
  end

  protected
  def conditions_for_collection
#    flash[:notice] = " condition " + @condition.to_s + " params " + params[:action].to_s + " last action " + $last_action.to_s
# $last_action = params[:action]

    # after update the condition is blank - not a fix ! - happens only in samples 
    if @condition.blank?
      @condition = ['samples.project_id = (?) and samples.approved = (?)', current_project_id, true ]
    end
    
    if current_user.data_entry_only
      ['samples.project_id = (?) and samples.approved = (?)', current_project_id, false ]        
    else
      @condition
    end
  end

end
