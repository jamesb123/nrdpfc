# == Schema Information
#
# Table name: microsatellite_horizontals
#
#  id            :integer(11)   not null, primary key
#  project_id    :integer(11)   
#  sample_id     :integer(11)   
#  organism_code :integer(11)   
#  org_sample    :integer(11)   
#  allelea       :integer(11)   
#  alleleb       :integer(11)   
#

class MicrosatelliteHorizontal < ActiveRecord::Base
  belongs_to :sample
  belongs_to :project
  has_many :microsatellites, :through => :sample
  
  class << self
    def table_name_for_project(project_id)
      "microsatellite_horizontals_#{project_id.to_i}"
    end
    
    def non_dynamic_columns_names
      %w[id project_id sample_id organism_code org_sample extraction_number]
    end
    
    include HorizontalClassCreatorSharedMethods

  end
  
  def authorized_for_create?
    true
  end
    
  def authorized_for_update?
    true
  end
  
  def authorized_for_read?
    true
  end

  def authorized_for_destroy?
    true
  end
  
#  def quoted_column_names(attributes = attributes_with_quotes)
#    attributes.keys.collect do |column_name|
#      self.class.connection.quote_column_name(column_name)
#    end
#  end
end
