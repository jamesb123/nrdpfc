class Sighting < ActiveRecord::Base
  extend Exportables::ExportableModel
  include SecuritySets::AdminOnly

  belongs_to :project
  has_many :surveys
  
end
