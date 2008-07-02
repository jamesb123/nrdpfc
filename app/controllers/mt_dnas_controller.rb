class MtDnasController < ApplicationController
  layout "tabs"
  include GoToOrganismCode::Controller
  active_scaffold :mt_dnas do |config|
    config.label = "mtDNA"
    config.columns = [:id, :project,  :sample, :locus, :haplotype, :gelNum, :wellNum, :finalResult, :comments]
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.create.columns.exclude :id, :project
    config.update.columns.exclude :id, :project
    config.columns[:sample].label = "Sample - Organism"
    config.columns[:finalResult].form_ui = :checkbox
    config.columns[:sample].form_ui = :record_select
    
  end
  
  include ResultTableSharedMethods
end
