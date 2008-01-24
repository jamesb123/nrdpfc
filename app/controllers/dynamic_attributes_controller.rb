load "#{RAILS_ROOT}/app/models/dynamic_attribute.rb"

class DynamicAttributesController < ApplicationController
  layout "tabs"
  active_scaffold :dynamic_attribute do |config|
    config.columns = [:name, :dynamic_type, :dynamic_class]  
    config.create.columns.exclude :project, :sample, :security_settings
    config.update.columns.exclude :project, :sample, :security_settings
    config.columns[:name].label = "Column Name"  
    config.columns[:dynamic_type].label = "Data Type"  
    config.columns[:dynamic_class].label = "Data Class"  
    config.columns[:dynamic_type].form_ui = :select
    config.columns[:dynamic_class].form_ui = :select
    config.columns[:scoper_type].label = "Scope Type - Project"  
    config.columns[:scoper_id].label = "Project ID"  
    config.columns[:owner_type].label = "Owner Type "  
  end
  
  def before_create_save(record)
    record.scoper = current_project
    record.owner_type = "Organism"
    true
  end
  
  def conditions_from_params
    w = Where.new
    w.and( "scoper_id = ? and scoper_type = ?", current_project.id, "Project" )
    w.to_sql
  end

end
