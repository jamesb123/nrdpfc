class QueryBuilder
  attr_accessor :limit
  
  def initialize(options = {})
    add_tables(*options[:tables])       if options[:tables]
    add_fields(options[:fields])       if options[:fields]
    add_order  (*options[:order_fields])  if options[:order_fields]
  end
  
  def add_tables(*table_names)
    table_names = table_names.flatten
    
    # find the shortest path to each table, and add it
    table_names.each do |table_name|
      next if tables.keys.map(&:to_s).include?(table_name.to_s)
      path = includes.model.path_to_exportable_table(table_name.to_s)
      raise "Sorry, couldn't find include path to table #{table_name}" if path.nil?
      add_include(*path)
    end
  end
  
  def add_include(*paths)
    path = paths*"/"
    
    root = cursor = includes
    
    added_node = nil
    
    path.split("/").each{|e|
      next if e.blank?
      e = e.to_sym
      if cursor[e].nil? 
        # try and add the node
        return nil if tables[e.pluralize] || tables[e.singularize]
        added_node = cursor.add_association(e)
        return nil if added_node.nil?
        tables.clear
      end
      cursor = cursor[e]
    }
    added_node
  end
  
  def add_fields(table_field_hash)
    table_field_hash.each_pair{|table_name, new_fields|
      table_name = table_name.to_sym
      new_fields = [new_fields] unless new_fields.is_a?(Array)
      for field in new_fields
        (t=tables[table_name]) && t.add_field(field)
        fields.clear
      end
    }
  end
  
  def add_filter(full_field_name, operation, value)
    full_field_name = translate_table_field_hash(full_field_name) if full_field_name.is_a?(Hash)
    filterings << [full_field_name, operation, value]
  end
  
  # full field name is {table}.{field}
  def add_order(full_field_name, asc_desc = :asc)
    full_field_name = translate_table_field_hash(full_field_name) if full_field_name.is_a?(Hash)
    order_fields << [full_field_name, asc_desc]
  end
  
  def filterings
    @filterings ||= []
  end
  
  def default_parent_table
    @default_parent_table ||= {:projects => QueryTable.new(:projects)}
  end
  
  def includes
    @includes ||= default_parent_table[:projects]
  end
    
  def order_fields
    @order_fields||=[]
  end
  
  def tables(reload = false)
    @tables = includes.flatten
  end
   
  # returns all fields from all tables from the query
  def fields(reload = false)
    @fields = [] if reload
    
    table_keys = tables(reload).keys.map(&:to_s)
    @fields = table_keys.sort.map {|key| tables[key.to_sym].fields }.flatten if @fields.blank?
    
    # @fields.sort! { |a,b| (a.seq||0) <=> (b.seq||0) }
    @fields
  end
  
  def select_field_aliases
    fields.map(&:field_alias)
  end
  
  def to_sql
    query_piece = QueryPiece.new :from => "projects"
    
    # joins must come first, because select statements may include joins that depend on the table being joined in already.
    query_piece += includes.joins
    
    fields.each{|f| query_piece += f.select_sql }
    filtering_piece = QueryPiece.new(:having => filterings.map{|column, operation, value| Where("#{column} #{operation} ?", value) })
    query_piece += filtering_piece
    sort_piece = QueryPiece.new(:order => order_fields.map{ |field_alias, direction| "#{field_alias} #{direction}"})
    query_piece += sort_piece
    query_piece += QueryPiece.new(:limit => limit) if limit
    query_piece.to_sql
  end
  
  #
  ##
  ###
  protected
    def translate_table_field_hash(hash)
      table_name = hash.keys.first
      field_name = hash[table_name]
      
      add_tables table_name
      field = tables[table_name.to_sym].add_field(field_name)
      field.field_alias   
    end
end