class DynamicAttribute < ActiveRecord::Base
  has_many :dynamic_attribute_values
  belongs_to :dynamic_type
  belongs_to :dynamic_class
  
  belongs_to :scoper, :polymorphic => true
end