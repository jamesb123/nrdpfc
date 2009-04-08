# == Schema Information
#
# Table name: mt_dnas
#
#  id          :integer(11)   not null, primary key
#  sample_id   :integer(11)   
#  project_id  :integer(11)   
#  locus       :string(255)   
#  haplotype   :string(12)    
#  gelNum      :string(255)   
#  wellNum     :string(255)   
#  finalResult :boolean(1)    
#

class MtDna < ActiveRecord::Base
  belongs_to :sample
  belongs_to :project
  belongs_to :locu
  
  before_create :assign_project_id
  after_save :flag_project_for_update
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  
  def assign_project_id
    self.project_id = current_project_id
  end
  
  def to_label
   "#{locus}" 
  end

  def flag_project_for_update
    Project.flag_for_update(self.project_id)
  end
  
end
