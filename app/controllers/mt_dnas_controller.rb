class MtDnasController < ApplicationController
  layout "tabs"

  active_scaffold :mt_dnas do |config|
    config.columns = [:project, :sample, :locus, :haplotype, :gelNum, :wellNum, :finalResult]
    config.create.columns.exclude :sample, :project
    config.update.columns.exclude :sample, :project
    config.columns[:sample].label = "Sample Info"  
    config.columns[:finalResult].form_ui = :checkbox
  end
  
  include ResultTableSharedMethods
end
