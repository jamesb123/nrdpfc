class RolesController < ApplicationController
  layout "tabs"
  active_scaffold :roles do |config|
    config.columns = [:short_role, :long_role]  
    config.columns[:short_role].label = "Short Description"  
    config.columns[:long_role].label = "Long Description"  
  end
end
