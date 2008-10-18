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
  # validates_presence_of :project_id
  validates_presence_of :user_id
  validates_presence_of :level
  
  NO_ACCESS   = 0
  READ_ONLY   = 1
  READ_WRITE  = 2
  READ_WRITE_DELETE  = 3
  
  LEVELS = [ ["No Access", NO_ACCESS], [ "Read Only", READ_ONLY], ["Read/Write", READ_WRITE], ["Full", READ_WRITE_DELETE] ].freeze

  before_create :assign_project_id

  include SecuritySets::AdminOnly
  
  def assign_project_id
    self.project_id = current_project_id
  end

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
  
end
