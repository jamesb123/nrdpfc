# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_nrdpfc_session_id'
  
  include AuthenticatedSystem
  
  prepend_before_filter :login_required  

  ActiveScaffold.set_defaults do |config|
    config.security.current_user_method = :current_user
    config.security.default_permission = false
  end

end
