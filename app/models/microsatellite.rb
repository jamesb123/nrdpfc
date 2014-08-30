# == Schema Information
#
# Table name: microsatellites
#
#  id          :integer(11)   not null, primary key
#  sample_id   :integer(11)   
#  project_id  :integer(11)   
#  locus       :string(30)    
#  allele1     :integer(11)   
#  allele2     :integer(11)   
#  gel         :string(255)   
#  well        :string(255)   
#  finalResult :boolean(1)    
#

class Microsatellite < ActiveRecord::Base
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
