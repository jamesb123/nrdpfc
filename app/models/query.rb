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
  belongs_to :project
  serialize :data
  
  def data
    val = super
    return val if val
    self.data = {}
  end
  
  # TODO - remove any defined select/sort fields not included in the table includes
  def garbage_collect!
    
  end
  
  def tables
    data[:tables]||=[]
  end
  
  def fields
    data[:fields]||=[]
  end
  
  def conditions
    data[:conditions]||=[]
  end
  
  def query_builder
    query_builder = QueryBuilder.new
    # TODO - finish here
  end
  
  def query
  end
  
end