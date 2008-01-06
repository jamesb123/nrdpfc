# == Schema Information
#
# Table name: microsatellite_horizontals
#
#  id            :integer(11)   not null, primary key
#  project_id    :integer(11)   
#  sample_id     :integer(11)   
#  organism_code :string(255)   
#  org_sample    :integer(11)   
#  allelea       :integer(11)   
#  alleleb       :integer(11)   
#

class MicrosatelliteHorizontal < ActiveRecord::Base
  belongs_to :sample
  belongs_to :project
  has_many :microsatellites, :through => :sample
  
  authorize_all_for_crud

  class << self
    def table_name_for_project(project_id)
      "microsatellite_horizontals_#{project_id.to_i}"
    end
    
    def non_dynamic_columns_names
      %w[id project_id sample_id organism_code org_sample]
    end
    
    include HorizontalClassCreatorSharedMethods

  end
end
