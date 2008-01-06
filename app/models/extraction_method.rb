# == Schema Information
#
# Table name: extraction_methods
#
#  id                            :integer(11)   not null, primary key
#  extraction_method_name        :string(255)   
#  extraction_method_description :string(255)   
#

class ExtractionMethod < ActiveRecord::Base
  has_many :samples
  
  def to_label 
    "#{extraction_method_name}" 
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
