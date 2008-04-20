class DnaResultsController < ApplicationController
  layout "tabs"
  
  include GoToOrganismCode::Controller
  active_scaffold :dna_results do |config|
    config.columns = [:sample, :project_id,  :prep_number, :extraction_number, 
     :barcode, :plate, :position, :extraction_method, :extraction_date, :extractor, 
     :extractor_comments, :fluoro_conc, :functional_conc, :pico_green_conc, :storage_building, 
      :storage_room, :storage_freezer, :storage_box, :xy_position, :dna_remaining]

    config.columns[:sample].sort_by :sql => 'organisms.organism_code'
    config.columns[:sample].includes << {:sample => :organism}
    
    config.list.columns.exclude :id, :project_id
    config.create.columns.exclude :id, :project_id, :sample
    config.update.columns.exclude  :id, :project_id, :sample
   
    config.columns[:sample].label = "Organism"  
    config.columns[:prep_number].label = "Prep. #"  
    config.columns[:extraction_number].label = "Extraction #"  
    config.columns[:fluoro_conc].label = "Flouro"
    config.columns[:functional_conc].label = "Functional"
    config.columns[:pico_green_conc].label = "Pico Green"
    config.columns[:barcode].label = "Bar Code"
    config.columns[:plate].label = "Plate"
    #config.action_links.add('go_to', :label => "Go To...", :page => true) 
  end 

  def conditions_for_collection
    ['samples.project_id = (?)', current_project_id ]
  end
end
