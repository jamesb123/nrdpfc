class MhcSeq < ActiveRecord::Base
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include ProjectRelations
  include SecuritySets::ProjectBased
  
  def to_label
    "#{locus}" 
  end

end
