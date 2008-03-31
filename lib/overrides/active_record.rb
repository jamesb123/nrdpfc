module ActiveRecord::AttributeMethods::ClassMethods
  INVALID_CHARS_REGEXP = /[^a-z_0-9\?]/i
  def evaluate_attribute_method_with_safety(attr_name, method_definition, method_name=attr_name)
    attr_name = attr_name.to_s
    if INVALID_CHARS_REGEXP.match(attr_name)
      new_attr_name = attr_name.gsub(INVALID_CHARS_REGEXP, "_")
      method_definition.gsub!("def #{attr_name}", "def #{new_attr_name}")
    end
    
    evaluate_attribute_method_without_safety(attr_name, method_definition, method_name)
  end
  
  alias_method_chain :evaluate_attribute_method, :safety
end

class ActiveRecord::Base
  def to_i
    self.id.to_i
  end
end

class ActiveRecord::Base
  def self.insert_query_for(attributes = {})
    set_values = attributes.collect do |key, value|
      "`#{key}` = '#{value.to_s.gsub("'", "''")}'"
    end
    "INSERT INTO #{table_name} set #{set_values.join(", ")}"
  end
  
  def self.insert(attributes = {})
    connection.execute(insert_query_for(attributes))
  end
end
