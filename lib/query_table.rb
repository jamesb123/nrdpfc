class QueryTable
  attr_reader :parent, :children, :class_name, :name, :fields
  
  def initialize(name, options = {})
    self.name = name.to_sym
    @children = {}
    @class_name = options[:class_name] || name.to_s.classify
    @parent = options[:parent]
    @fields = []
  end
  
  def keys
    children.keys
  end
  
  def [](key)
    children[key]
  end
  
  def []=(key, value)
    children[key] = value
  end
  
  def name=(value)
    parent.children.delete(@name) if parent
    @name = value
    parent.children[@name] = self if parent
  end
  
  def add_child_table(name)
    association = model.reflections[name]
    return nil if association.nil?
    
    children[name] = QueryTable.new(name, 
      :class_name => association.class_name,
      :parent => self
    )
  end
  
  def join_sql
    return nil unless parent
    table_name = model.table_name
    parent_table_name = parent.model.table_name
    table_alias = (table_name != name.to_s) ? " #{name}" : ""
    
    
  end
  
  def model
    class_name.constantize
  end
  
  def add_field(name)
    # TODO - add check for field to make sure it's valid
    new_field = QueryField.new(name, :table => self)
    fields << new_field
    new_field
  end
  
  def flatten
    tables = {self.name => self}
    children.each_pair{|key, child|
      tables.merge!(child.flatten)
    }
    tables
  end
  
  def to_hash
    hash = { name => {}}
    children.each_pair{|key, child|
      hash[name].merge! child.to_hash
    }
    hash
  end
end
