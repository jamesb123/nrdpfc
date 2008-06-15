class Document < ActiveRecord::Base
  has_many_dynamic_attributes :versioned => true

  def is_flex_attribute?(attr_name, model)
    attr_name =~ /attr$/
  end
end