class QueryField
  attr_accessor :seq, :name, :sort
  attr_reader :table
  
  def initialize(name, options = {})
    self.sort = nil
    self.name = name
    self.seq = options[:seq]
    self.table = options[:table]
  end
  
  def sort=
    
  end
end