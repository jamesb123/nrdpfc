class UsersController < ApplicationController
  layout "tabs"
  
  active_scaffold :users do |config|
    config.columns = [:login, :email, :is_admin, :data_entry_only, :projects, :name]
    config.create.columns = [:login, :email, :is_admin, :data_entry_only, :password, :password_confirmation, :default_project, :name ]
    config.update.columns = [:login, :email, :is_admin, :data_entry_only, :password, :password_confirmation, :default_project, :name ]
    config.subform.columns = [:login]
  config.columns[:name].label = "Real Name"
    config.columns[:is_admin].label = "Administrator"
    config.columns[:is_admin].form_ui = :checkbox
    config.columns[:data_entry_only].form_ui = :checkbox
    config.columns[:projects].tooltip = "Projects this user manages."
    config.columns[:is_admin].tooltip = <<-END
      Admins have privileges to edit users,<br/>
      and projects and grant privileges to<br/>
      any project. They don't have to be<br/>
      the manager of any specific project.
    END

    config.columns[:default_project].form_ui = :select
  end
  def change_password
    
  end
  protected
  def create_authorized?
    current_user&& current_user.is_admin
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
    
