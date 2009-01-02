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

require_or_load "query_table.rb"
require_or_load "query_field.rb"

class Query < ActiveRecord::Base
  belongs_to :project
  serialize :data
  
  def data
    val = super
    return val if val
    self.data = {}
  end
  
  # def tables
  #   data[:tables]||=[]
  # end
  # 
  # def fields
  #   data[:fields]||= Exportables::ExportableModel.models.inject({}) do | hash, model|
  #     hash[model.exportable_name] = []
  #     hash
  #   end
  # end
  # 
  # def fields=(value)
  #   data[:fields] = value
  # end
  # 
  # def tables=(value)
  #   data[:tables] = value
  # end
  # 
  # def orderings=(value)
  #   data[:orderings] = value
  # end
  # 
  # def conditions
  #   data[:conditions]||=[]
  # end
  
  def query_builder
    qb = QueryBuilder.new

    qb.calculate_common_join_table( data.collect {|table, fields| table } )
    
    data.each_pair do |table, fields|
      qb.add_tables table
      
      fields.each_pair do |field, options|
        qb.add_fields table => field
        qb.add_order({table => field}, options[:order]) unless options[:order].blank?
        
        if options[:filters]
          filters = options[:filters]
          filters[:operator].each_with_index do |op, index|
            value = filters[:value][index]
            qb.add_filter(table, field, op, value)
          end
        end
      end
    end
    
    qb.filter_by_project(ActiveRecord::Base.current_project_id) if ActiveRecord::Base.current_project
    
    qb
  end
  
  def query
  end
  
end
