class Snp < ActiveRecord::Base
  belongs_to :locu
  belongs_to :sample
  belongs_to :project  
  before_save :assign_locus_text
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  include ProjectRelations
  include ApprovalModelHelpers
  
  def assign_locus_text
    self.locus = self.locu.to_label unless self.locu.nil?
  end
  
  def to_label
   "#{self.locus} #{allele1} - #{allele2}"
  end
  
end
