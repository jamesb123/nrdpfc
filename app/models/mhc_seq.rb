class MhcSeq < ActiveRecord::Base
  belongs_to :project
  belongs_to :sample
  
  before_create :assign_project_id
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  
  def assign_project_id
    self.project_id = current_project_id
  end
  
  def to_label
    "#{locus}" 
  end

end
