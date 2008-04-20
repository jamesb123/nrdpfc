class MtDnasController < ApplicationController
  layout "tabs"
  active_scaffold :mt_dnas do |config|
    config.label = "mtDNA"
    config.columns = [:project,  :sample, :locus, :haplotype, :gelNum, :wellNum, :finalResult]
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.create.columns.exclude :sample, :project
    config.update.columns.exclude :sample, :project
    config.columns[:sample].label = "Organism"  
    config.columns[:finalResult].form_ui = :checkbox
    #config.action_links.add('go_to', :label => "Go To...", :page => true) 
    
  end
  
  include ResultTableSharedMethods
end
