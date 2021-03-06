class YChromosomesController < ApplicationController
  layout "tabs"
  active_scaffold :y_chromosomes do |config|
    config.label = "y Chromosome"
    config.columns = [:project, :sample, :sample_id, :locu, :locus, :haplotype,  :wellNum, :gelNum, :comments, :finalResult]

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}
    
    config.create.columns.exclude :project, :sample_id
    config.update.columns.exclude :project, :sample_id
    config.list.columns.exclude :project

    # search associated sample colum
    config.columns[:sample].search_sql = 'organisms.organism_code'
    config.search.columns << :sample

    config.nested.add_link("Y Chromosome Seqs", [:y_chromosome_seqs])
    config.columns[:sample].label = "Organism Code or Sample ID"
    config.columns[:sample_id].label = "Sample ID"
    config.columns[:finalResult].form_ui = :checkbox
    config.columns[:sample].form_ui = :record_select
    config.columns[:locus].label = "Locus Text"
    config.columns[:locu].label = "Locus"
    config.columns[:locu].form_ui = :select
  end
  
  include ApprovedDataOnly
  include ResultTableSharedMethods  
  include GoToOrganismCode::Controller

end