# == Schema Information
#
# Table name: shippingmaterials
#
#  id                :integer(11)   not null, primary key
#  medium_short_desc :string(255)   
#  medium_long_desc  :string(255)   
#

class Shippingmaterial < ActiveRecord::Base

  has_many :samples

  def to_label
    "#{medium_short_desc}"
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
