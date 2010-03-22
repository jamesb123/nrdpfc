class Sighting < ActiveRecord::Base
  extend Exportables::ExportableModel
  include SecuritySets::AdminOnly

#  has_many :surveys
  
end
