class GendersController < ApplicationController
  layout "tabs"
  active_scaffold :genders do |config|
    config.columns = [:id, :project, :sample, :gender, :locus, :wellNum, :gelNum, :finalResult]
    config.create.columns.exclude :id, :project, :sample, :security_settings
    config.update.columns.exclude :id, :project, :sample, :security_settings
    config.list.columns.exclude :project

    config.columns[:id].label = "ID"
    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}
    
    config.columns[:sample].label = "Organism"  
    config.columns[:finalResult].form_ui = :checkbox
    
    
  end
  
  include ResultTableSharedMethods  
  include GoToOrganismCode::Controller
  
end
