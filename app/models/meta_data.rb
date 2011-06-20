class MetaData < ActiveRecord::Base
  has_many :projects
  
  include SecuritySets::ProjectBased
  include ProjectRelations
  include ApprovalModelHelpers

  # name of stored document using file_column
  file_column :m_document_name
    
  def to_label
    "#{m_name}"
  end

end
