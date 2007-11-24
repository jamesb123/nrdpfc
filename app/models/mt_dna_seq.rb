# == Schema Information
#
# Table name: mt_dna_seqs
#
#  id         :integer(11)   not null, primary key
#  project_id :integer(11)   
#  locus      :string(255)   
#  haplotype  :string(255)   
#  sequence   :text          
#

class MtDnaSeq < ActiveRecord::Base
  belongs_to :project
  
  before_create :assign_project_id

  def assign_project_id
    self.project_id = current_user.current_project.id
  end
  
  
   def to_label
    "#{locus}" 
   end

  def security_settings
    current_user.authorization_display_for project
  end

  def authorized_for_create?
    true
  end
  
  def authorized_for_update?
    # this method gets called for rows and for Class level questions, so this check returns true at the class level
    return true unless existing_record_check?
    
    current_user.authorized_security_for?(project, SecuritySetting::READ_WRITE)
  end
  
  def authorized_for_read?
    return true unless existing_record_check?

    current_user.authorized_security_for?(project, SecuritySetting::READ_ONLY)
  end

  def authorized_for_destroy?
    return true unless existing_record_check?

    current_user.authorized_security_for?(project, SecuritySetting::READ_WRITE_DELETE)
  end
  
end