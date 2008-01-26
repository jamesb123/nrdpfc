class QueryBuilder
  attr_accessor :limit
  
  def initialize(options = {})
    add_tables(*options[:tables])       if options[:tables]
    add_fields(options[:fields])       if options[:fields]
    add_sort  (*options[:sort_fields])  if options[:sort_fields]
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
      
      for field in new_fields
        (t=tables[table_name]) && t.add_field(field)
        fields.clear
      end
    }
  end
  
  # full field name is {table}.{field}
  def add_sort(full_field_name, asc_desc = :asc)
    sort_fields << [full_field_name, asc_desc]
  end
  
  def default_parent_table
    @default_parent_table ||= {:projects => QueryTable.new(:projects)}
  end
  
  def includes
    @includes ||= default_parent_table[:projects]
  end
    
  def sort_fields
    @sort_fields||=[]
    # TODO - return, in order, all of the fields for sorting
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

    sort_piece = QueryPiece.new(:order => sort_fields.map{ |field_alias, direction| "#{field_alias} #{direction}"})
    query_piece += sort_piece
    query_piece += QueryPiece.new(:limit => limit) if limit
    query_piece.to_sql
  end
end