require 'active_record/has_many_dynamic_attributes'

ActiveRecord::Base.send :include, ActiveRecord::HasManyDynamicAttributes

# Add models
require 'models/dynamic_attribute'
require 'models/dynamic_attribute_value'
require 'models/dynamic_class'
require 'models/dynamic_type'