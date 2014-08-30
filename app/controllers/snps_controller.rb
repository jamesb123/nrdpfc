class SnpsController < ApplicationController
  layout "tabs"
  active_scaffold :snps do |config|
    list.columns = [ :sample, :sample_id, :locus, :allele1, :allele2, :plate, :well, :comments,  :date_genotyped]
    update.columns = [ :locu, :allele1, :allele2, :plate, :well, :comments,  :date_genotyped]
    create.columns = [ :sample, :locu, :allele1, :allele2, :plate, :well, :comments,  :date_genotyped]
    
    columns[:sample].sort_by :sql => "organisms.organism_code"
    columns[:sample].includes << {:sample => :organism}
    create.columns.exclude :project, :sample_id
    update.columns.exclude :project, :sample, :sample_id
    list.columns.exclude :locu_id

    # search associated sample colum
    columns[:sample].search_sql = 'organisms.organism_code'
    search.columns << :sample

    # columns = config.columns
    columns[:sample].label = "Organism Code - Index"
    columns[:sample_id].label = "Sample ID"
    columns[:allele1].label = "Allele 1"
    columns[:allele2].label = "Allele 2"
    columns[:locus].label = "Locus"
    columns[:locu].label = "Locus"
    columns[:date_genotyped].label = "Date Genotyped (YMD)"
    
    columns[:sample].form_ui = :record_select
    columns[:locu].form_ui = :select
  end
  include ResultTableSharedMethods
  include GoToOrganismCode::Controller

end
