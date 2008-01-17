# == Schema Information
#
# Table name: queries
#
#  id         :integer(11)   not null, primary key
#  project_id :integer(11)   
#  name       :string(100)   
#  draft      :boolean(1)    default(true)
#  data       :text          
#  created_at :datetime      
#  updated_at :datetime      
#

require "query_table.rb"
require "query_field.rb"

class Query < ActiveRecord::Base
  serialize :data
  belongs_to :project
  has_many :query_tables
  has_many :query_fields
  
  def data
    val = super
    return val if val
    self.data = {}
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
    table_field_hash.each_pair{|table, new_fields|
      table = table.to_sym
      
      for field in new_fields
        tables[table].add_field(field)
        fields.clear
      end
    }
  end
  
  # full field name is {table}.{field}
  def add_sort(full_field_name, asc_desc = :asc)
    sort_fields << [full_field_name, asc_desc]
  end
  
  def includes
    data[:includes] ||= QueryTable.new(:project)
  end
  
  def select_fields
    data[:select_fields] ||= {}
  end
  
  def sort_fields
    @sort_fields||=[]
    # TODO - return, in order, all of the fields for sorting
  end
  
  def tables(reload = false)
    @tables = {} if reload
    @tables = includes.flatten if @tables.blank?
    @tables
  end
   
  # returns all fields from all tables from the query
  def fields(reload = false)
    @fields = [] if reload
    
    @fields = tables(reload).map {|key, table| table.fields }.flatten if @fields.blank?
    
    # @fields.sort! { |a,b| (a.seq||0) <=> (b.seq||0) }
    @fields
  end
  
  # TODO - remove any defined select/sort fields not included in the table includes
  def garbage_collect!
    
  end
  
  def to_sql
    query_piece = QueryPiece.new :from => "projects"
    
    fields.each{|f|
      query_piece += f.select_sql
      # h += f.order_sql if f.sort_direction
    }
    # t.name  tables.values.map(&:name)   includes  data[:includes].to_hash
    query_piece += includes.joins
    
    sort_piece = QueryPiece.new(:order => sort_fields.map{ |field_alias, direction| "#{field_alias} #{direction}"})
    query_piece += sort_piece
    
    query_piece.to_sql
  end
end