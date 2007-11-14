# == Schema Information
#
# Table name: locality_types
#
#  id                 :integer(11)   not null, primary key
#  locality_type_name :string(255)   
#  locality_type_desc :string(255)   
#

class LocalityType < ActiveRecord::Base
  
  has_many :samples
  
  def to_label
    "#{locality_type_name}"
  end

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
