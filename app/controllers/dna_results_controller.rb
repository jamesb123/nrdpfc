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
    
    config.columns[:sample].tooltip = <<-END
    This is a compliation of the "Organism Code" <br>
    and "Organism Sample Index" from the "Sample" table.<br>
    For example, the third sample from individual EGL00001 would be EGL00001-3
    END

    config.columns[:sample_id].tooltip = <<-END
    The unique number given to each sample<br>
    by the database in the "Sample" table.
    END
    config.columns[:prep_number].tooltip = <<-END
    If you have multiple preparations for this sample, this is the number of that preparation.  If you just have one preparation, then this value should be 1.
    END
    
    config.columns[:extraction_number].tooltip = <<-END
    The number of times you have extracted from this preparation - represented by the DNA data in this row.
    END
    
    config.columns[:barcode].tooltip = <<-END
    The bar code for the tube in which the stock DNA is stored
    END
    
    config.columns[:extraction_date].tooltip = <<-END
    The date on which the extraction was conducted
    END

    config.columns[:fluoro_conc].tooltip = <<-END
    The concentration of the stock DNA based on a fluorometer reading.  This is an older method that we used to use to quantify DNA.
    END
    
    config.columns[:functional_conc].tooltip = <<-END
    The concentration of the stock DNA based on functional amplification (if conducted).  This field allows the user to differentiation between the actual concentration of DNA, and the functional concentration of DNA (e.g. due to inhibotors, degradation, etc...).
    END
    
    config.columns[:pico_green_conc].tooltip = <<-END
    The concentration of the stock DNA based on PicoGreen quantification.
    END
    
    config.columns[:barcode].tooltip = <<-END
    The bar code for the tube in which the stock DNA is stored
    END
    
    config.columns[:plate].tooltip = <<-END
    The bar code for the plate in which the stock DNA is stored
    END
  
  end 

  include ResultTableSharedMethods  
  include GoToOrganismCode::Controller

  def conditions_for_collection
    ['dna_results.project_id = (?)', current_project_id ]
  end
end
