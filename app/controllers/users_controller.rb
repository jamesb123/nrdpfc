class UsersController < ApplicationController
  layout "tabs"
  active_scaffold :users do |config|
    config.columns = [:login, :email]
    config.actions.exclude :create, :delete
  end
  
end

  #  config.actions = [:create, :update, :show]  

    #config.actions.exclude :create
    #config.actions.add :delete
