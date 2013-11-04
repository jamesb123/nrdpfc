class SsamplesController < ApplicationController
  layout "tabs"
  before_filter :update_table_config
  CHICKEN_INCLUDE = [:chicken_barcode, :chicken_sample_date, :chicken_contact, :chicken_company, :chicken_strain, :chicken_feathering, :chicken_package, :chicken_declared_gender, :chicken_meat_part, :chicken_ml_duplicate, :chicken_comments]
  WOLF_EXCLUDE_LIST =   [:sample_bc, :project, :type_lat_long, :locality_type, :locality_type_text,  :security_settings, :approved, :date_submitted, :sample_id, :organism_id, :discrepancy_comments,:remote_data_entry, :id]
  WHALES_EXCLUDE_LIST = [:sample_bc, :project, :type_lat_long, :locality_type, :locality_type_text,  :security_settings, :approved, :remote_data_Entry, :platebc, :plateposition, :country,
  :province, :location_measurement_method, :location_1, :location_2, :location_accuracy,:age, :condition, :rehydrated, :diet_analysis ]
  
  WHALES_EXCLUDE = [:sample_id, :project, :id, :organism_id, :type_lat_long,  :locality_type, :locality_type_text, :platebc, :plateposition, :country, 
  :province, :location_measurement_method, :location_1, :location_2,  :location_accuracy,
  :security_settings, :approved, :remote_data_Entry,:age, :condition, :rehydrated, :diet_analysis]

  WOLF_EXCLUDE1 =     [:sample_id, :project, :id, :organism_id, :type_lat_long, :locality_type,  :security_settings, :approved, :discrepancy_comments, :remote_data_entry ]
  
  SAMPLES_COLUMNS = [:id, :organism_id, :organism, :organism_index, :sample_bc, :field_code, :country, :province, 
    :locality, :locality_type_text, :locality_comments, 
    :location_1, :location_2, :location_accuracy,  
    :latitude, :longitude, :coordinate_system,  :location_measurement_method,    
    :collected_on_day,  :collected_on_month, :collected_on_year, :collected_by, :collector_comments, 
    :date_received, :received_by, :receiver_comments, :date_submitted, :submitted_by,  
    :submitter_comments, :tissue_type, :extraction_method, :shipping_material_txt_prv,
    :platebc, :plateposition, :batch_number, 
    :storage_medium_text, :storage_building, :storage_room, :storage_fridge, :storage_box,
    :xy_position, :tissue_remaining,  :security_settings,:approved, 
    :shipping_date, :field_ident, :current_location, :comments, :import_permit, :export_permit,
    :profiling_completed,:profiling_done_by,:profiling_funded_by,:profile_published, :publication_name, :profiling_date, :photo_id, :discrepancy_comments, :sample_image1 ]

  def update_table_config
#    active_scaffold_config.columns.exclude SAMPLES_COLUMNS 
#    active_scaffold_config.columns.add SAMPLES_COLUMNS 

    # variable labels
    @proj = Project.find(current_project_id)
    active_scaffold_config.columns[:photo_id].label = @proj.photo_id_label 
    active_scaffold_config.columns[:field_ident].label = @proj.field_ident_label 
    active_scaffold_config.columns[:organism].label = @proj.organism_label 
    
    # project based columns
    if !@proj.opt_col_1.nil? && !@proj.opt_col_1.empty? 
      active_scaffold_config.list.columns.add @proj.opt_col_1
      active_scaffold_config.create.columns.add @proj.opt_col_1
      active_scaffold_config.update.columns.add @proj.opt_col_1
      active_scaffold_config.show.columns.add @proj.opt_col_1
    end
    if !@proj.opt_col_2.nil? && !@proj.opt_col_2.empty? 
      active_scaffold_config.list.columns.add @proj.opt_col_2
      active_scaffold_config.create.columns.add @proj.opt_col_2
      active_scaffold_config.update.columns.add @proj.opt_col_2
      active_scaffold_config.show.columns.add @proj.opt_col_2
    end
    if !@proj.opt_col_3.nil? && !@proj.opt_col_3.empty? 
      active_scaffold_config.list.columns.add @proj.opt_col_3
      active_scaffold_config.create.columns.add @proj.opt_col_3
      active_scaffold_config.update.columns.add @proj.opt_col_3
      active_scaffold_config.show.columns.add @proj.opt_col_3
    end
    if !@proj.opt_col_4.nil? && !@proj.opt_col_4.empty? 
      active_scaffold_config.list.columns.add @proj.opt_col_4
      active_scaffold_config.create.columns.add @proj.opt_col_4
      active_scaffold_config.update.columns.add @proj.opt_col_4
      active_scaffold_config.show.columns.add @proj.opt_col_4
    end

    # columns for road runner / chickens
    if current_project_id == 66
        active_scaffold_config.list.columns.add CHICKEN_INCLUDE
        active_scaffold_config.create.columns.add CHICKEN_INCLUDE
        active_scaffold_config.update.columns.add CHICKEN_INCLUDE
        active_scaffold_config.show.columns.add CHICKEN_INCLUDE
    else
        active_scaffold_config.list.columns.exclude CHICKEN_INCLUDE
        active_scaffold_config.create.columns.exclude CHICKEN_INCLUDE
        active_scaffold_config.update.columns.exclude CHICKEN_INCLUDE
        active_scaffold_config.show.columns.exclude CHICKEN_INCLUDE
    end
  end



  include ActionView::Helpers::FormOptionsHelper
#  protect_from_forgery :except => [:samples_field_code] 
  
  record_select :per_page => 20,
                :search_on => ['organisms.organism_code'],
                :order_by => 'samples.id'
 
  def record_select_includes; :organism; end

  def record_select_conditions_from_controller
    [ 'samples.project_id = ?', current_project_id ]
  end

  include GoToOrganismCode::Controller  

  active_scaffold :samples do |config|
    config.columns = SAMPLES_COLUMNS 
    config.columns[:organism].search_sql = 'organisms.organism_code'
    config.search.columns << :organism
    config.columns[:organism].sort_by :sql => "organisms.organism_code"
    config.list.columns.exclude  :project_id
    config.create.columns.exclude :id, :project_id, :date_submitted, :sample_id, :organism_id
    config.update.columns.exclude :id,:project_id, :date_submitted, :sample_id, :organism_id
    config.show.columns.exclude :project_id, :date_submitted, :sample_id, :organism_id

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
    
    config.columns[:id].label = "ID"
    config.columns[:organism].label = "Org Code"
    config.columns[:organism_index].label = "Org Samp Indx"
    config.columns[:date_received].label = "Date Received"
    config.columns[:received_by].label = "Received by"
    config.columns[:date_submitted].label = "Date Submitted"
    config.columns[:submitted_by].label = "Submitted by"
    config.columns[:locality].label = "Locality"
    config.columns[:text_tissue_type].label = "Tissue Type"
    config.columns[:batch_number].label = "Batch"
    config.columns[:collected_on_year].label = "Year Coll"
    config.columns[:province].label = "PR"

    config.columns[:tissue_type].form_ui = :select
    config.columns[:organism].form_ui = :select

  end

  include ApprovedDataOnly

end
