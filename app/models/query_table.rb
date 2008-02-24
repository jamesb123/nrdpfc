class QueryTable
  attr_reader :parent, :children, :class_name, :name, :fields
  
  def initialize(name, options = {})
    @children = {}
    @name = name.to_sym
    @class_name = options[:class_name] || @name.to_s.classify
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
  
  def title
    name.to_s.titleize
  end
  
  def association_names
    model.exportable_reflections.keys.map(&:to_s).sort
  end
  
  def add_association(name)
    association = model.reflections[name.to_sym]
    raise ArgumentError, "association #{name} non-existant for #{self.model}" if association.nil?
    
    children[name] = QueryTable.new(name, 
      :class_name => association.class_name,
      :parent => self
    )
  end
  
  def root
    parent.nil? ? self : parent.root
  end
  
  def all_table_names
    ([self.name.to_s] + children.values.map { |child| child.all_table_names }).flatten
  end
  
  def joins(query_tables_included = [name])
    query_piece = QueryPiece.new
    children.each{|association_name, query_table|
      query_piece += model.exportable_join(association_name, query_tables_included)
      query_tables_included << query_table
      query_piece += query_table.joins(query_tables_included)
    }
    
    query_piece
  end
  
  def model
    class_name.constantize
  end
  
  def add_field(name)
    name = name.to_sym
    fields.each{ |f| return f if f.name == name }
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
  
  def select_sql(name)
    model.exportable_select(name)
  end
end
