class DynamicAttributesController < ApplicationController
  layout "tabs"
  active_scaffold :dynamic_attributes do |config|
    config.columns = [:id, :name, :dynamic_type_id, :dynamic_class_id, :scoper_type, :scoper_id, :owner_type]  
    config.create.columns.exclude :project, :sample, :security_settings
    config.update.columns.exclude :project, :sample, :security_settings
    config.columns[:name].label = "Column Name"  
    config.columns[:dynamic_type_id].label = "Data Type"  
    config.columns[:dynamic_class_id].label = "Data Class"  
    config.columns[:scoper_type].label = "Scope Type - Project"  
    config.columns[:scoper_id].label = "Project ID"  
    config.columns[:owner_type].label = "Owner Type "  
  end

end
