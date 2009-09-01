# Table name: dynamic_attributes
#  id               :integer(11)   not null, primary key
#  name             :string(255)   
#  dynamic_type_id  :integer(11)   
#  dynamic_class_id :integer(11)   
#  scoper_type      :string(255)   
#  scoper_id        :integer(11)   
#  owner_type       :string(255)   
#
load "#{RAILS_ROOT}/app/models/dynamic_attribute.rb"

class DynamicAttributesController < ApplicationController
  layout "tabs"
  active_scaffold :dynamic_attribute do |config|
    config.columns = [:name, :dynamic_type]  
    config.columns[:name].label = "Column Name"  
    config.columns[:dynamic_type].label = "Data Type"  
    config.columns[:dynamic_type].form_ui = :select
  end
  
  def before_create_save(record)
    record.dynamic_class_id = 0
    record.scoper = current_project
    record.owner_type = "organism"
    if record.name.nil? && record.dynamic_type_id.nil?
      flash[:notice] = "You must fill in something !"
      false
    else
      true
    end
  end
  
  def conditions_from_params
    w = Where.new
    w.and( "scoper_id = ? and scoper_type = ?", current_project_id, "Project" )
    w.to_sql
  end

end
