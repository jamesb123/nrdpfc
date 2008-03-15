class MtDnasController < ApplicationController
  layout "tabs"
  active_scaffold :mt_dnas do |config|
    config.label = "mtDNA"
    config.columns = [:id, :sample_id, :project,  :sample, :locus, :haplotype, :gelNum, :wellNum, :finalResult]
    config.list.columns.exclude :project
    list.sorting = {:sample => 'ASC'}
    config.create.columns.exclude :sample, :project
    config.update.columns.exclude :sample, :project
    config.columns[:sample_id].label = "Sample ID"  
    config.columns[:sample].label = "Sample Info"  
    config.columns[:finalResult].form_ui = :checkbox
  end
  
  include ResultTableSharedMethods
end
