class GendersController < ApplicationController
  layout "tabs"
  active_scaffold :genders do |config|
    config.columns = [:project, :sample, :sample_id, :gender, :locus, :wellNum, :gelNum, :comments, :finalResult]

    config.columns[:sample].label = "Organism Code (SID)"
    config.columns[:sample_id].label = "Sample ID"
    config.create.columns.exclude :project, :sample_id
    config.update.columns.exclude :project, :sample_id
    config.list.columns.exclude :project

    config.columns[:sample].sort_by :sql => "Organism Code or Sample ID"
    config.columns[:sample].includes << {:sample => :organism}

    config.columns[:finalResult].form_ui = :checkbox
#    config.columns[:sample].form_ui = :record_select
    config.columns[:sample].form_ui = :select
  end
  
  include ResultTableSharedMethods  
  include GoToOrganismCode::Controller

  def conditions_for_collection
    ['samples.project_id = (?)', current_project_id ]
  end  
end
