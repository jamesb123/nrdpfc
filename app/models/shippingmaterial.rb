# == Schema Information
#
# Table name: shippingmaterials
#
#  id                :integer(11)   not null, primary key
#  medium_short_desc :string(255)   
#  medium_long_desc  :string(255)   
#

class Shippingmaterial < ActiveRecord::Base

  include SecuritySets::AllowAll
  
  def to_label
    "#{medium_short_desc}"
  end
end
