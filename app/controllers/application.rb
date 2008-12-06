# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
# test new respository - jim

require "current_project_helpers"
require 'digest/sha1'

class ApplicationController < ActionController::Base

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_nrdpfc_session_id'
  
  include AuthenticatedSystem
  include CurrentProjectHelper

  prepend_before_filter :login_required  
  
  ActiveScaffold.set_defaults do |config|
    config.security.current_user_method = :current_user
    config.security.default_permission = false
    config.actions.exclude :live_search
    config.actions.add :search
  end
  
  # This isn't working, I'm not quite sure why...
  # something isn't scoped right...
  def self.is_project_manager
    user = current_user
    return false if ! user
    return false if ! session[:project_id]
    project = Project.find_by_id(session[:project_id])
    return false if ! project
    @project_manager = (project.user_id == user.id)
  end

  def download_table
    model = active_scaffold_config.model

    file = Tempfile.new(model.table_name)
    file.close

    q = QueryBuilder.new(:tables => [ model.table_name ])
    results = model.connection.select_all(q.to_sql + "where samples.project_id = #{current_project_id}")

    unless results.empty?
      FasterCSV.open(file.path, "w") do |csv|
        csv << results[0].keys
        results.each {|res| csv << res.values }
      end
    end

    send_file file.path, :filename => "#{model.table_name}.csv", :type => 'text/csv'
  end
end
