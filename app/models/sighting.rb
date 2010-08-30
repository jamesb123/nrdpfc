class Sighting < ActiveRecord::Base

  extend Exportables::ExportableModel
  include SecuritySets::ProjectBased
#  include ProjectRelations
  include ApprovalModelHelpers

  
  belongs_to :project
  def to_label
    return "ID: #{id}"
  end
  
end
