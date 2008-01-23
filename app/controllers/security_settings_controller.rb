class SecuritySettingsController < ApplicationController
  layout "tabs"
  
  active_scaffold :security_settings do |config|
    config.columns = [:project, :user, :to_label, :level]
    config.columns[:project].form_ui = :select
    config.columns[:user].form_ui = :select
    config.columns[:to_label].form_ui = :select
    columns[:to_label].label = "Security Setting"
    columns[:to_label].sort_by :sql => 'level' 
    config.list.sorting = {:to_label => :asc}
    columns[:level].label = "Security Setting"
    
    config.list.columns.exclude :level
    config.create.columns.exclude :id, :to_label 
    config.update.columns.exclude :id, :to_label
  end

  def conditions_for_collection
    ['projects.user_id = (?)', current_user.id]
  end

end