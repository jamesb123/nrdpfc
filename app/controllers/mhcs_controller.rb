class MhcsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mhcs do |config|
    config.columns = [:project, :sample, :locus, :allele1, :allele2, :gelNum, :wellNum, :finalResult, :security_settings]
    config.create.columns.exclude :sample, :project, :security_settings
    config.update.columns.exclude :sample, :project, :security_settings
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.columns[:sample].label = "Organism"
    config.columns[:allele1].label = "Allele 1"
    config.columns[:allele2].label = "Allele 2"    
    config.columns[:gelNum].label = "Gel Num"
    config.columns[:finalResult].form_ui = :checkbox
    #config.action_links.add('go_to', :label => "Go To...", :page => true) 
    
  end

  include ResultTableSharedMethods
end
