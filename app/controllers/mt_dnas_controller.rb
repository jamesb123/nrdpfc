class MtDnasController < ApplicationController
  layout "tabs"
  include GoToOrganismCode::Controller
  active_scaffold :mt_dnas do |config|
    config.label = "mtDNA"
    config.columns = [:id, :project,  :sample, :locus, :haplotype, :gelNum, :wellNum, :finalResult, :accession, :comments]
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.create.columns.exclude :id, :sample, :project
    config.update.columns.exclude :id, :sample, :project
    config.columns[:sample].label = "Organism"  
    config.columns[:finalResult].form_ui = :checkbox
    
    # config.columns[:id].label = "ID"
    # config.columns[:sample_id].form_ui = :select
      
  end
  
  include ResultTableSharedMethods
end
