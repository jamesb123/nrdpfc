class UsersController < ApplicationController
  layout "tabs"
  
  require 'project_manager_access_only'
  # include ProjectManagerAccessOnly
  
  active_scaffold :users do |config|
    config.columns = [:login, :email]
    config.create.columns = [:login, :email, :password, :password_confirmation]
    config.update.columns = [:login, :email, :password, :password_confirmation]
    config.subform.columns = [:login]
  end
  
end

  #  config.actions = [:create, :update, :show]  

    #config.actions.exclude :create
    #config.actions.add :delete
    
