class Survey < ActiveRecord::Base

  extend Exportables::ExportableModel
  include SecuritySets::AdminOnly

#  belongs to :sightings

end
