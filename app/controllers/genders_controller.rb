class GendersController < ApplicationController
  layout "tabs"
  active_scaffold :genders do |config|
    config.columns = [:project, :sample, :gender, :locus, :wellNum, :gelNum, :comments, :finalResult]

    config.create.columns.exclude :project
    config.update.columns.exclude :project
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.columns[:finalResult].form_ui = :checkbox
    config.columns[:sample].form_ui = :record_select
  end
  
  include ResultTableSharedMethods  
  include GoToOrganismCode::Controller
  
end
