class MessageController < ApplicationController
  skip_before_filter :project_required
  skip_before_filter :login_required
  layout "tabs"
  def no_current_project
    
  end
end