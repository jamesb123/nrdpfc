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
        return nil if all_tables.include?(e.pluralize) || all_tables.include?(e.singularize)
        added_node = cursor.add(e)
        return nil if added_node.nil?
        @all_tables = nil
      end
      cursor = cursor[e]
    }
    added_node
  end
  
  def add_fields(table_field_hash)
    table_field_hash.each_pair{|table, fields|
      table = table.to_sym
      next if table
      select_fields[table]||=[]
      select_fields[table]+= select_fields.map(&:to_sym)
    }
  end
  
  # full field name is {table}_{field}
  def add_sort(full_field_name)
    sort_fields << full_field_name
  end
  
  def includes
    data[:includes] ||= QueryIncludeNode.new(:project)
  end
  
  def select_fields
    data[:select_fields] ||= {}
  end
  
  def sort_fields
    
  end
  
  def tables(reload = false)
    @tables = nil if reload
    @tables ||= includes.flatten
  end
  
  def fields(reload = false)
    @fields = nil if reload
    
    @fields ||= tables(reload).map {|key, field|
      field
    }.flatten
  end
  
  # remove any defined select/sort fields not included in the table includes
  def garbage_collect!
    
  end
  
#  def to_sql
#    [:select, :from, :join, :group].inject({})parts = {
#      :select => [],
#      
#    }
end

