class DnaResultsController < ApplicationController
  layout "tabs"
  
  include GoToOrganismCode::Controller
  active_scaffold :dna_results do |config|
    config.columns = [:project, :sample, :sample_id, :prep_number, :extraction_number, 
     :barcode, :plate, :position, :extraction_method, :extraction_date, :extractor, 
     :extractor_comments, :fluoro_conc, :functional_conc, :pico_green_conc, :storage_building, 
     :storage_room, :storage_freezer, :storage_box, :xy_position, :dna_remaining, :comments]

    # search associated sample colum
    config.columns[:sample].search_sql = 'organisms.organism_code'
    config.search.columns << :sample

    config.columns[:sample].sort_by :sql => 'organisms.organism_code'
    config.columns[:sample].includes << {:sample => :organism}

    config.list.columns.exclude :project
    config.create.columns.exclude :project, :sample_id
    config.update.columns.exclude  :project, :sample_id

    config.columns[:sample].label = "Organism Code - Organism Index:   Sample ID"
    config.columns[:sample_id].label = "Sample ID"
    config.columns[:prep_number].label = "Prep. #"  
    config.columns[:extraction_number].label = "Extraction #"  
    config.columns[:extraction_date].label = "Extraction Date"  
    config.columns[:fluoro_conc].label = "Fluoro."
    config.columns[:functional_conc].label = "Functional"
    config.columns[:pico_green_conc].label = "Pico Green"
    config.columns[:barcode].label = "Bar Code"
    config.columns[:plate].label = "Plate"
    config.columns[:sample].form_ui = :record_select
#   config.columns[:sample].form_ui = :select
  end 

  include ResultTableSharedMethods  
  include GoToOrganismCode::Controller

  def conditions_for_collection
    ['dna_results.project_id = (?)', current_project_id ]
  end
end
