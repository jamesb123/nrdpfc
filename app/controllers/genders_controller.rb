class GendersController < ApplicationController
  layout "tabs"
  active_scaffold :genders do |config|
    config.columns = [:project, :sample, :gender, :locus, :wellNum, :gelNum, :finalResult]
    config.create.columns.exclude :project, :sample, :security_settings
    config.update.columns.exclude :project, :sample, :security_settings
    config.list.columns.exclude :project
    #list.sorting = {:sample => 'ASC'}
    config.columns[:sample].includes = [:sample]
    config.columns[:sample].sort_by :sql => "samples.organism_code"
    
    config.columns[:sample].label = "Organism"  
    config.columns[:finalResult].form_ui = :checkbox
  end
  
  include ResultTableSharedMethods
end
