class GendersController < ApplicationController
  layout "tabs"
  active_scaffold :genders do |config|
    config.columns = [:project, :sample, :gender, :wellNum, :gelNum, :finalResult, :security_settings]  
    config.create.columns.exclude :project, :sample, :security_settings
    config.update.columns.exclude :project, :sample, :security_settings

    config.columns[:sample].label = "Sample Info"  
    # config.columns[:gender].label = "Gender"  

    # config.list.columns.exclude :project
  end
end