class UsersController < ApplicationController
  layout "tabs"
  
  active_scaffold :users do |config|
    config.columns = [:login, :email, :is_admin, :projects]
    config.create.columns = [:login, :email, :is_admin, :password, :password_confirmation, :projects]
    config.update.columns = [:login, :email, :is_admin, :password, :password_confirmation, :projects]
    config.subform.columns = [:login]
    config.columns[:is_admin].label = "Administrator"
    config.columns[:is_admin].form_ui = :checkbox
    config.columns[:projects].label = "Projects"
    config.columns[:projects].form_ui = :select
  end
  
  def create_authorized?
    current_user && current_user.is_admin
  end

  def read_authorized?
    current_user && current_user.is_admin
  end

  def update_authorized?
    current_user && current_user.is_admin
  end

  def delete_authorized?
    current_user && current_user.is_admin
  end

end

  #  config.actions = [:create, :update, :show]  

    #config.actions.exclude :create
    #config.actions.add :delete
    
