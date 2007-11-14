require 'ostruct'
class SearchBuilder
  attr_reader :object
  attr_accessor :where
  
  def object=(value)
    value=OpenStruct.new(value) if value.is_a?(Hash)
    @object = value
  end
  
  def initialize(target_object, options={})
    self.object = target_object
    self.where = options[:append_to] || Where.new
    @table_prefix = ""
  end
  
  def and(*params, &block)
    @where.and(*params, &block)
  end
  
  def or(*params, &block)
    @where.or(*params, &block)  
  end
  
  def to_sql(*params)
    @where.to_sql(*params)
  end
  
  alias to_s :to_sql
  
  def range_on(field, options={})
    options = options.clone
    min_param = options[:min_param] || "#{options[:param] || field}_min"
    max_param = options[:max_param] || "#{options[:param] || field}_max"
    cast = options[:cast] || :string
    
    process_clause(field, ">= ?", options.merge(:param => min_param))
    process_clause(field, "<= ?", options.merge(:param => max_param))
    
    self
  end
  
  def like_on(field, options={})
    options = options.clone
    options[:suffix] ||= "%"
    
    process_clause(field, "like ?", options)
  end
  
  def for_table(table, &block)
    if block_given?
      last_table_prefix = @table_prefix
    end
    
    @table_prefix = "#{table}."
      
    if block_given?
      yield
      
      @table_prefix = last_table_prefix
    end
    
  end
  
  def equal_on(field, options={})
    options = options.clone
    options[:cast] = :string
    process_clause(field, "= ?", options)
  end
  
  def in_on(field, options={})
    options = options.clone
    options[:cast] ||= :array
    process_clause(field, "in (?)", options)
  end
  
  def process_clause(field, operator_clause, options={})
    param = options[:param] || field
    self.and_unless_blank("#{@table_prefix}#{field} #{operator_clause}", value_for(param, options[:cast]), options)
    
    self
  end

  def and_unless_blank(condition, value, options={})
    value = value.compact if (Array === value)
    
    # if value is an empty array or a blank string, don't filter on it
    return self if value.blank?
    
    prefix = options[:prefix]
    suffix = options[:suffix]
    if prefix || suffix
      @where.and(condition, [prefix, value, suffix].compact.to_s )
    else
      @where.and(condition, value)
    end
    
    self
  end
  
  def value_for(param, cast=:string)
    param = param.to_s
    if param.include?(".")
      param=param.split(".").last
    end
    cast_to( object.send(param), cast)
  end
  
  def cast_to(value, type)
    self.class.cast_to(value, type)
  end
  
  def self.cast_to(value, type)
    return value if value.nil?
    
    case type
    when nil
      value
    when :array
      value = Array===value ? value : [value]
    when :time
      Time.parse(value)
    when :date
      Time.parse(value).to_date
    when :i, :int, :integer
      value.to_i
    when :f, :float
      value.to_f
    when :string
      value.to_s
    else
      raise "unknown cast type: #{type}"
    end
    
  end
end