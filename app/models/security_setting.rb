# == Schema Information
#
# Table name: security_settings
#
#  id         :integer(11)   not null, primary key
#  project_id :integer(11)   
#  user_id    :integer(11)   
#  level      :integer(11)   default(0)
#

class SecuritySetting < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates_uniqueness_of :user_id, :scope => :project_id, :message => "has already been assigned a security setting for this project."
  validates_presence_of :project_id
  validates_presence_of :user_id
  validates_presence_of :level
  
  NO_ACCESS   = 0
  READ_ONLY   = 1
  READ_WRITE  = 2
  READ_WRITE_DELETE  = 3
  
  LEVELS = [ ["No Access", NO_ACCESS], [ "Read Only", READ_ONLY], ["Read/Write", READ_WRITE], ["Full", READ_WRITE_DELETE] ].freeze

  def level_option_for_select_selected
    the_level = SecuritySetting::LEVELS.detect {|the_level| self.level == the_level[1]}
    if the_level
      the_level[1]
    else
      SecuritySetting::LEVELS[0][1]
    end
  end
  
  def to_label
    the_level = SecuritySetting::LEVELS.detect {|the_level| self.level == the_level[1]}
    if the_level
      the_level[0]
    else
      SecuritySetting::LEVELS[0][0]
    end
  end
  
  def authorized_for_create?
logger.debug("!!!!!!! authorized_for_create self = #{self.inspect}")    
    true
  end
    
  def authorized_for_update?
    # this method gets called for rows and for Class level questions, so this check returns true at the class level
    return true unless existing_record_check?
    logger.debug("!!!!!!! authorized_for_update self = #{self.inspect}")

#    if !self.project
#      logger.debug("!!!!!!! new record. params = #{params[:record][:project_id]}")
#      project = Project.find(params[:record][:project_id])
#    else
      project = self.project
#    end  
    current_user.authorized_security_for?(project, SecuritySetting::READ_WRITE)
  end
  
  def authorized_for_read?
    return true unless existing_record_check?
    current_user.authorized_security_for?(self.project, SecuritySetting::READ_ONLY)
  end

  def authorized_for_destroy?
    return true unless existing_record_check?
    current_user.authorized_security_for?(self.project, SecuritySetting::READ_WRITE_DELETE)
  end
      
end
