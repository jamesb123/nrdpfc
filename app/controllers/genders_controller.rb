class GendersController < ApplicationController
  layout "tabs"
  active_scaffold :genders do |config|
    config.columns = [:project, :sample, :gender, :locus, :wellNum, :gelNum, :finalResult]
    config.create.columns.exclude :project, :sample, :security_settings
    config.update.columns.exclude :project, :sample, :security_settings
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}
    
    config.columns[:sample].label = "Organism"  
    config.columns[:finalResult].form_ui = :checkbox
    #config.action_links.add('go_to', :label => "Go To...", :page => true) 
    
  end
  
  include ResultTableSharedMethods  
  include GoToOrganismCode::Controller
  
end
