class MhcsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mhcs do |config|
    config.columns = [:id, :sample_id, :project, :sample, :locus, :allele1, :allele2, :gelNum, :wellNum, :finalResult, :security_settings]
    config.create.columns.exclude :id, :sample, :project
    config.update.columns.exclude :id, :sample, :project
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.columns[:sample_id].label = "Sample ID"
    config.columns[:sample].label = "Organism"
    config.columns[:allele1].label = "Allele 1"
    config.columns[:allele2].label = "Allele 2"    
    config.columns[:gelNum].label = "Gel Num"
    config.columns[:finalResult].form_ui = :checkbox
    config.columns[:sample_id].form_ui = :select
    
  end

  include ResultTableSharedMethods
  include GoToOrganismCode::Controller
  
end
