# == Schema Information
#
# Table name: microsatellite_organism_horizontals
#
#  id            :integer(11)   not null, primary key
#  project_id    :integer(11)   
#  organism_id   :integer(11)   
#  organism_code :integer(11)   
#  allelea       :integer(11)   
#  alleleb       :integer(11)   
#

class MicrosatelliteOrganismHorizontal < ActiveRecord::Base
  belongs_to :organism
  belongs_to :project
  has_many :final_microsatellites, :through => :organism
  
  class << self
    def table_name_for_project(project_id)
      "microsatellite_organism_horizontals_#{project_id.to_i}"
    end
    
    def non_dynamic_columns_names
      %w[id project_id organism_id organism_code extraction_number]
    end
    
  end
  extend HorizontalClassCreatorSharedMethods
  
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
  
end

  
