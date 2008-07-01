class MhcsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mhcs do |config|
    config.columns = [:project, :sample, :locus, :allele1, :allele2, :gelNum, :wellNum, :comments, :finalResult]
    config.create.columns.exclude :id, :sample, :project
    config.update.columns.exclude :id, :sample, :project
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.columns[:sample].label = "Organism"
    config.columns[:allele1].label = "Allele 1"
    config.columns[:allele2].label = "Allele 2"    
    config.columns[:gelNum].label = "Gel Num"
    config.columns[:finalResult].form_ui = :checkbox
    
  end

  include ResultTableSharedMethods
  include GoToOrganismCode::Controller
  
end
