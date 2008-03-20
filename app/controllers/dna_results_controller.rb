class DnaResultsController < ApplicationController
  layout "tabs"
  active_scaffold :dna_results do |config|
    config.columns = [:id, :project_id, :sample, :prep_number, :extraction_number, 
     :barcode, :plate, :position, :extraction_method, :extraction_date, :extractor, 
     :extractor_comments, :fluoro_conc, :functional_conc, :pico_green_conc, :storage_building, 
      :storage_room, :storage_freezer, :storage_box, :xy_position, :dna_remaining]


# last_transaction_date is a virtual column that references a joined field 
# active_scaffold :users do | config |
#   config.columns = [:name, :last_transaction_date, :status]  
#   config.columns[:last_transaction_date] = "Last transaction date"
#   config.columns[:last_transaction_date].includes = [:user_transactions]
#   config.columns[:last_transaction_date].sort_by :sql => "user_transactions.created_at"
# end   
   
   
  # config.columns[:sample].includes = [:samples]
  # config.columns[:sample].sort_by :sql => "samples.organism_code"
    list.sorting = {:sample => 'ASC'}
  
    config.list.columns.exclude :id, :project_id
    config.create.columns.exclude :id, :project_id
    config.update.columns.exclude  :id, :project_id
   
    config.columns[:sample].label = "Organism"  
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
