# == Schema Information
#
# Table name: genders
#
#  id          :integer(11)   not null, primary key
#  sample_id   :integer(11)   
#  project_id  :integer(11)   
#  gender      :string(255)   
#  gelNum      :string(255)   
#  wellNum     :string(255)   
#  finalResult :boolean(1)    
#  locus       :string(255)   
#

class Gender < ActiveRecord::Base
  belongs_to :sample
  belongs_to :project
    
  before_create :assign_project_id
  after_save :flag_project_for_update
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  
  validates_presence_of :locus
  
  def flag_project_for_update
    Project.flag_for_update(self.project_id)
  end

  def assign_project_id
    self.project_id = current_project_id
  end
  
  def to_label 
    "#{id}" 
  end
  
end
