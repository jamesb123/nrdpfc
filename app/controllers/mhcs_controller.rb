class MhcsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mhcs do |config|
    config.columns = [:project, :sample, :sample_id, :locu, :locus, :allele1, :allele2, :gelNum, :wellNum, :comments, :finalResult, :approved]
    config.create.columns.exclude :project, :sample_id
    config.update.columns.exclude :project, :sample_id
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    # search associated sample colum
    config.columns[:sample].search_sql = 'organisms.organism_code'
    config.search.columns << :sample

    config.columns[:sample].label = "Organism Code or Sample ID"
    config.columns[:sample_id].label = "Sample ID"
    config.columns[:allele1].label = "Allele 1"
    config.columns[:allele2].label = "Allele 2"    
    config.columns[:gelNum].label = "Gel Num"
    config.columns[:finalResult].form_ui = :checkbox
    config.columns[:sample].form_ui = :record_select
    config.columns[:locus].label = "Locus Text"
    config.columns[:locu].label = "Locus"
    config.columns[:locu].form_ui = :select
  end

  include ResultTableSharedMethods
  include GoToOrganismCode::Controller
  include ApprovedDataOnly
end
