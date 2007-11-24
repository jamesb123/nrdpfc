module ActiveRecord::AttributeMethods::ClassMethods
  def evaluate_attribute_method_with_safety(attr_name, method_definition, method_name=attr_name)
    invalid_chars_regexp = /[^a-z_0-9\?]/i
    if invalid_chars_regexp.match(attr_name)
      new_attr_name = attr_name.gsub(invalid_chars_regexp, "_")
      method_definition.gsub!("def #{attr_name}", "def #{new_attr_name}")
    end
    
    evaluate_attribute_method_without_safety(attr_name, method_definition, method_name)
  end
  
  alias_method_chain :evaluate_attribute_method, :safety
end