class Survey < ActiveRecord::Base

  extend Exportables::ExportableModel
  include SecuritySets::AdminOnly

  belongs_to :project
  belongs_to :sighting
  
end
