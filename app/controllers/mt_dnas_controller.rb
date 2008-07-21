class MtDnasController < ApplicationController
  layout "tabs"
  include GoToOrganismCode::Controller
  active_scaffold :mt_dnas do |config|
    config.label = "mtDNA"
    config.columns = [:project, :sample,  :sample_id,  :locus, :haplotype, :gelNum, :wellNum, :finalResult, :comments]
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.create.columns.exclude :project, :sample_id
    config.update.columns.exclude :project, :sample_id
    config.columns[:sample].label = "Organism Code or Sample ID"
    config.columns[:sample_id].label = "Sample ID"
    config.columns[:finalResult].form_ui = :checkbox
#    config.columns[:sample].form_ui = :record_select
    config.columns[:sample].form_ui = :select
    
  end
  
  include ResultTableSharedMethods
end
