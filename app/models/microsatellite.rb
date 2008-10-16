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
  belongs_to :sample
  belongs_to :project
  
  before_create :assign_project_id
  after_save :flag_project_for_update
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  
  def assign_project_id
    self.project_id = current_project_id
  end
  
  def to_label
   "#{self.locus} #{allele1} - #{allele2}"
  end

  def flag_project_for_update
    Project.flag_for_update(self.project_id)
  end
  
end
