class Sighting < ActiveRecord::Base

  extend Exportables::ExportableModel
  include SecuritySets::ProjectBased
  include ProjectRelations
  include ApprovalModelHelpers

  
  belongs_to :project
  
end
