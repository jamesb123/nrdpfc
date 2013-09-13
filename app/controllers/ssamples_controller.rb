class SsamplesController < ApplicationController
  layout "tabs"
  before_filter :update_table_config

  SAMPLES_COLUMNS = [:id, :project_id, :organism, :organism_index, :sample_bc, :field_code, :batch_number, :date_collected, :collected_on_year, :province, :locality, :text_tissue_type, :date_submitted, :submitted_by, :date_received, :received_by]

  def update_table_config
    @proj = Project.find(current_project_id)
    active_scaffold_config.columns[:photo_id].label = @proj.photo_id_label 
    active_scaffold_config.columns[:field_ident].label = @proj.field_ident_label 
    active_scaffold_config.columns[:organism].label = @proj.organism_label 
    # columns for road runner / chickens
    if current_project_id = 66
        active_scaffold_config.list.columns.add strain
        active_scaffold_config.create.columns.add strain
        active_scaffold_config.update.columns.add strain
        active_scaffold_config.show.columns.add strain
    else
        active_scaffold_config.list.columns.exclude strain
        active_scaffold_config.create.columns.exclude strain
        active_scaffold_config.update.columns.exclude strain
        active_scaffold_config.show.columns.exclude strain
    end
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
