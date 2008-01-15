class QueryPiece
  LIST_ATTRIBUTES = [:select, :join, :having, :where, :order, :group]
  SINGLE_ATTRIBUTES = [:from, :limit]
  
  attr_accessor *(LIST_ATTRIBUTES + SINGLE_ATTRIBUTES)
  
  def initialize(options = {})
    LIST_ATTRIBUTES.each do |k|
      v = options[k] || []
      v = [v] unless v.is_a?(Array)
      
      instance_variable_set("@#{k}", v)
    end
    
    SINGLE_ATTRIBUTES.each do |k|
      instance_variable_set("@#{k}", options[k])
    end
  end
  
  def +(other)
    other = other.new(other) if other.is_a?(Hash)
    raise ArgumentError unless other.is_a?(QueryPiece)
    raise ArgumentError, "Both source and other have from attributes: #{self.from}, #{other.from})" if self.from && other.from
    
    source = self.deep_clone
    
    LIST_ATTRIBUTES.each do |attr|
      other_value = other.send(attr)
      
      source.send(attr).concat(other_value) if other_value
    end
    
    source[:from] ||= other[:from]
    source[:limit] ||= other[:limit]
    
    source
  end
  
  def [](key)
    send(key)
  end
  
  def []=(key, value)
    send("#{key}=", value)
  end
  
  def deep_clone; Marshal.load(Marshal.dump(self)); end
  
  def to_sql
    q = ""
    q << "SELECT #{select * ', '}\n"
    q << "FROM #{from}\n"
    q << "#{join * '\n'}\n" unless join.blank?
    q << "WHERE " + (where.map{ |w| "(#{w})" } * " AND ") + "\n" unless where.blank?
    q << "HAVING " + (having.map{ |h| "(#{h})" } * " AND ") + "\n" unless having.blank?
    q << "LIMIT #{limit}\n" if limit
    
    
  end
end