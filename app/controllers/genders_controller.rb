class GendersController < ApplicationController
  layout "tabs"
  active_scaffold :genders do |config|
    config.columns = [:id, :sample_id, :project, :sample, :gender, :locus, :wellNum, :gelNum, :finalResult]

    config.create.columns.exclude :id, :project, :sample 
    config.update.columns.exclude :id, :project, :sample
    config.list.columns.exclude :project

    config.columns[:id].label = "ID"
    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.columns[:sample_id].label = "Sample ID"
    config.columns[:sample].label = "Organism"  
    config.columns[:finalResult].form_ui = :checkbox
    config.columns[:sample_id].form_ui = :select

    
  end
  
  include ResultTableSharedMethods  
  include GoToOrganismCode::Controller
  
end
