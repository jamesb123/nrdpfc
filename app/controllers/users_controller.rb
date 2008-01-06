class UsersController < ApplicationController
  layout "tabs"
  
  active_scaffold :users do |config|
    config.columns = [:login, :email, :projects, :security_settings]
    
    config.create.columns.exclude :id
    config.update.columns.exclude :id
    config.list.columns.exclude :security_settings
  end
  
  
end

