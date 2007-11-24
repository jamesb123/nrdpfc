class GendersController < ApplicationController
  layout "tabs"
  active_scaffold :genders do |config|
    config.columns = [:project, :sample, :gender, :wellNum, :gelNum, :finalResult, :security_settings]  
    config.create.columns.exclude :project, :sample, :security_settings
    config.update.columns.exclude :project, :sample, :security_settings

    config.columns[:sample].label = "Sample Info"  
    config.columns[:finalResult].form_ui = :checkbox
  end
  
  include ResultTableSharedMethods
end
