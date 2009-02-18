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
  include InPlaceEditing
  
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
    # Horizontals use magic to define their tables so we have to use
    # reverse magic to figure it out
    table_name = self.class.respond_to?(:target_table_name) ?
                   self.class.target_table_name.to_s :
                   active_scaffold_config.model.table_name

    table = table_name.intern
    q = QueryBuilder.new(:parent => table, :tables => [ table ], :fields => { table => "*" })
    q.filter_by_project(current_project_id) unless (table == :projects)

    csv_string = FasterCSV.generate do |csv|
      csv << q.column_headers
      q.results.each {|result| csv << result }
    end

    send_data csv_string, :filename => "#{table_name}.csv"
  end
end
