class ProjectManagersController < ApplicationController
  layout "tabs"

  active_scaffold :users do |config|
    config.label = "Project Managers"
    config.columns = [:login, :current_project]
    config.columns[:current_project].set_link('edit', :params => {:inline => true})
    config.update.columns = [:current_project]
    config.actions.exclude :create, :delete
    
  end
  
  ActiveScaffold.set_defaults do |config|
    config.security.current_user_method = :current_login
  end

  protected

  def current_login
    current_user
  end

end