class Survey < ActiveRecord::Base
  extend Exportables::ExportableModel
  include SecuritySets::ProjectBased
#  include ProjectRelations
  include ApprovalModelHelpers

  belongs_to :project
  has_many :sightings  
  def to_label
    return "ID: #{id}"
  end
end
