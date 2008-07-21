class MhcsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mhcs do |config|
    config.columns = [:project, :sample, :sample_id, :locus, :allele1, :allele2, :gelNum, :wellNum, :comments, :finalResult]
    config.create.columns.exclude :project, :sample_id
    config.update.columns.exclude :project, :sample_id
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.columns[:sample].label = "Organism Code or Sample ID"
    config.columns[:sample_id].label = "Sample ID"
    config.columns[:allele1].label = "Allele 1"
    config.columns[:allele2].label = "Allele 2"    
    config.columns[:gelNum].label = "Gel Num"
    config.columns[:finalResult].form_ui = :checkbox
#    config.columns[:sample].form_ui = :record_select
    config.columns[:sample].form_ui = :select

  end

  include ResultTableSharedMethods
  include GoToOrganismCode::Controller

  def conditions_for_collection
    ['samples.project_id = (?)', current_project_id ]
  end
end
