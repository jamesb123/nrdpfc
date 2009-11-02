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
  belongs_to :locu
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  include ProjectResults

  before_save :assign_approval

  def assign_approval
    if ! current_user.data_entry_only
       self.approved = true
    end
  end 
  
  def to_label
   "#{locus}" 
  end
  
  def approved_authorized?
    ! current_user.data_entry_only    
  end
  
  def approved_authorized_for_update?
    current_user.is_admin    
  end

  def approved_authorized_for_create?
    current_user.is_admin    
  end
  
end
