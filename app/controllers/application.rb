# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
# test new respository - jim

require "current_project_helpers"

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
end
