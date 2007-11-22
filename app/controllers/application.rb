# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
# test new respository - jim
class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_nrdpfc_session_id'
  
  include AuthenticatedSystem
  
  prepend_before_filter :login_required  

  ActiveScaffold.set_defaults do |config|
    config.security.current_user_method = :current_user
    config.security.default_permission = false
  end
  def current_project=(project)
    project_id = project.is_a?(Project) ? project.id : project
    
    session[:project_id] = project_id
  end
  
  def current_project
    return @current_project if @current_project 
    current_project_id = session[:project_id] || (current_user.current_project && current_user.current_project.id)
    @current_project = current_project_id && Project.find(current_project_id)
    @current_project || nil
  end
  helper_method :current_project=, :current_project
end
