class DnaResultsController < ApplicationController
  layout "tabs"
  active_scaffold :dna_results do |config|
    config.columns = [:id, :project_id, :sample, :prep_number, :extraction_number, 
     :barcode, :plate, :position, :extraction_method, :extraction_date, :extractor, 
     :extractor_comments, :fluoro_conc, :functional_conc, :pico_green_conc, :storage_building, 
      :storage_room, :storage_freezer, :storage_box, :xy_position, :dna_remaining]

   #config.columns[:sample_info].includes = [:samples]
   #config.columns[:sample_info].sort_by :sql => "samples.organism_id"
  
    #config.list.columns.exclude :project
    #config.create.columns.exclude :project
    #config.update.columns.exclude  :project
    list.sorting = {:sample => 'ASC'}
    # To sort by an SQL expression
    config.columns[:sample].label = "Organism"  
   # config.columns[:sample_id].label = "Sample ID"  
    config.columns[:prep_number].label = "Prep. #"  
    config.columns[:extraction_number].label = "Extraction #"  
    config.columns[:fluoro_conc].label = "Flouro"
    config.columns[:functional_conc].label = "Functional"
    config.columns[:pico_green_conc].label = "Pico Green"
    config.columns[:barcode].label = "Bar Code"
    config.columns[:plate].label = "Plate"
     # columns[:sample].sort_by :sql => 'sample_id '
  end

  def conditions_for_collection
    ['samples.project_id = (?)', current_project.id ]

  end
  
end
