# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
# test new respository - jim
class ApplicationController < ActionController::Base

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_nrdpfc_session_id'
  
  include AuthenticatedSystem
  prepend_before_filter :login_required  
  # prepend_before_filter :project_required
  
  ActiveScaffold.set_defaults do |config|
    config.security.current_user_method = :current_user
    config.security.default_permission = false
  end
  
  # This should implement the Go to functionality
  def go_to
    render :text => "Not yet implemented...", :layout => false
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
  
  def project_required
    if current_user && current_project.nil?
      redirect_to :controller => "message", :action => "no_current_project"
      return false
    end
  end
end
