# == Schema Information
#
# Table name: mhcs
#
#  id          :integer(11)   not null, primary key
#  sample_id   :integer(11)   
#  project_id  :integer(11)   
#  locus       :string(255)   
#  allele1     :string(255)   
#  allele2     :string(255)   
#  gelNum      :string(255)   
#  wellNum     :string(255)   
#  finalResult :boolean(1)    
#

class Mhc < ActiveRecord::Base
  belongs_to :locu
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  include ProjectRelations
  include ApprovalModelHelpers
  
  def to_label 
    "Ex#: #{locus}" 
  end
  def assign_locus_text
    self.locus = self.locu.to_label unless self.locu.nil?
  end
end
