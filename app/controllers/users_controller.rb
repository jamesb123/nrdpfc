class UsersController < ApplicationController
  layout "tabs"
  active_scaffold :users do |config|
    config.columns = [:login, :email]
    config.create.columns = [:login, :email, :password, :password_confirmation]
  end
  
  # These go somewhere else...
  def password_form_column(record, field_name)
    password_field_tag field_name, record.password
  end
  
  def password_confirmation_form_column(record, field_name)
    password_field_tag field_name, record.password_confirmation
  end

end

  #  config.actions = [:create, :update, :show]  

    #config.actions.exclude :create
    #config.actions.add :delete
    
