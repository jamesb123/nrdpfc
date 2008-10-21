class QueryPiece
  LIST_ATTRIBUTES = [:select, :join, :having, :where, :order, :group]
  SINGLE_ATTRIBUTES = [:from, :limit]
  
  attr_accessor *(LIST_ATTRIBUTES + SINGLE_ATTRIBUTES)
  
  def initialize(options = {})
    options.assert_valid_keys( *(LIST_ATTRIBUTES + SINGLE_ATTRIBUTES) )
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
    other = new(other) if other.is_a?(Hash)
    raise ArgumentError, "Trying to sum up a QueryPiece with a non-QueryPiece object of type #{other.class} - #{other.inspect}" unless other.is_a?(QueryPiece)
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
    select_fields = select.empty? ? ["*"] : select
    
    q = ""
# JWB added DISTINCT clause 2008/10/21
#    q << "SELECT #{select_fields * ', '}\n"
    q << "SELECT DISTINCT #{select_fields * ', '}\n"
    q << "FROM #{from}\n"
    q << "#{join * "\n"}\n" unless join.blank?
    q << "WHERE " + (where.map{ |w| "(#{w})" } * " AND ") + "\n" unless where.blank?
    q << "HAVING " + (having.map{ |h| "(#{h})" } * " AND ") + "\n" unless having.blank?
    
    # q << "GROUP BY " + pieces[:group]*", ") unless pieces[:group].blank?
    q << "ORDER BY #{order * ', '}\n" unless order.blank?
    q << "LIMIT #{limit}\n" if limit
    q
  end
  
  
  alias to_s to_sql
end