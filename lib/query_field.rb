class QueryField
  attr_accessor :seq, :name, :sort_direction, :table
  
  def initialize(name, options = {})
    self.sort_direction = nil
    self.name = name
    self.seq = options[:seq]
    self.table = options[:table]
  end
  
  def sort=
    
  end
end