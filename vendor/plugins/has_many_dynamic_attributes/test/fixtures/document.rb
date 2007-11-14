class Document < ActiveRecord::Base
  has_flex_attributes :versioned => true

  def is_flex_attribute?(attr_name, model)
    attr_name =~ /attr$/
  end
end