class QueryField
  attr_accessor :sequence, :name, :sort_direction, :table
  
  def initialize(name, options = {})
    @sort_direction = nil
    @name = name.to_sym
    @sequence = options[:sequence]
    @table = options[:table]
  end
  
  def sort=
    
  end
  
  def field_alias
    "#{table.name}_#{name}"
  end
  
  def select_sql
    table.select_sql(name)
  end
  
  def title
    name.to_s.titleize
  end
end