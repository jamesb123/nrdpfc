class SecuritySettingsController < ApplicationController
  layout "tabs"
  # version 6
  active_scaffold :security_settings do |config|
    config.columns = [:project, :user, :to_label, :level]

    config.columns[:project].form_ui = :select

    config.columns[:user].form_ui = :select
    config.columns[:to_label].form_ui = :select

    config.columns[:to_label].label = "Security Setting"
    config.columns[:to_label].sort_by :sql => 'level' 

    config.list.sorting = {:to_label => :asc}

    config.list.columns.exclude :level
    config.create.columns.exclude :to_label
    config.update.columns.exclude :to_label
  end

  def conditions_for_collection
    # Admins can see all users and if they don't have read
    # permissions, the projects table won't be included
    # in the query
    unless current_user.is_admin || !authorized_for?(:action => :read)
      # If not, and admin, only show security settings
      # they manage
      ['projects.user_id = (?)', current_user.id]
#    ['(projects.user_id = (?) OR EXISTS (SELECT 1 FROM security_settings where security_settings.project_id = projects.id AND security_settings.user_id = ? AND security_settings.level > 0))', current_user.id, current_user.id]
    end
  end
end
