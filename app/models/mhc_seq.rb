class MhcSeq < ActiveRecord::Base
  
  extend Exportables::ExportableModel
  include ProjectRelations
  include SecuritySets::ProjectBased

  belongs_to :mhc
  belongs_to :locu
  belongs_to :project
  
  def to_label
    "#{locus}" 
  end

end
