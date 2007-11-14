class DynamicAttributeValue < ActiveRecord::Base
  belongs_to :dynamic_attribute
  belongs_to :owner, :polymorphic => true  
  
  def value
    send "#{storage_field}"
  end

  def storage_field
    dynamic_attribute.dynamic_type.stored_in_field
  end
    
end