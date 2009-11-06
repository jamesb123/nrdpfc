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
  belongs_to :locu
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  include ProjectRelations
  include ApprovalModelHelpers
  
  def to_label
   "#{locus}" 
  end
end
