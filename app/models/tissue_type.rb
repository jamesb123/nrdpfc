# == Schema Information
#
# Table name: tissue_types
#
#  id          :integer(11)   not null, primary key
#  tissue_type :string(255)   
#  comment     :string(255)   
#

class TissueType < ActiveRecord::Base
  extend Exportables::ExportableModel
  
  has_many :samples

  def to_label
    "#{tissue_type}"
  end

  # def security_settings
  #  current_user.authorization_display_for self.project
  # end

  def authorized_for_create?
    true
  end
  
  def authorized_for_update?
    true
  end
  
  def authorized_for_read?
    true
  end

  def authorized_for_destroy?
    true
  end

end
