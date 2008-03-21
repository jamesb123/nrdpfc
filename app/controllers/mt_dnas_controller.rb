class MtDnasController < ApplicationController
  layout "tabs"
  active_scaffold :mt_dnas do |config|
    config.label = "mtDNA"
    config.columns = [:id, :project,  :sample, :locus, :haplotype, :gelNum, :wellNum, :finalResult]
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    
    config.create.columns.exclude :sample, :project
    config.update.columns.exclude :sample, :project
    config.columns[:sample].label = "Organism"  
    config.columns[:finalResult].form_ui = :checkbox
  end
  
  include ResultTableSharedMethods

  def joins_for_collection
    'LEFT OUTER JOIN `organisms` ON `organisms`.id = `samples`.organism_id'
  end

end
