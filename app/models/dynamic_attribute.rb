# == Schema Information
#
# Table name: dynamic_attributes
#
#  id               :integer(11)   not null, primary key
#  name             :string(255)   
#  dynamic_type_id  :integer(11)   
#  dynamic_class_id :integer(11)   
#  scoper_type      :string(255)   
#  scoper_id        :integer(11)   
#  owner_type       :string(255)   
#

class DynamicAttribute < ActiveRecord::Base
  has_many :dynamic_attribute_values
  belongs_to :dynamic_type
  belongs_to :dynamic_class
  
  belongs_to :scoper, :polymorphic => true
  
  def authorized_for_update?
    # this method gets called for rows and for Class level questions, so this check returns true at the class level
    return true unless existing_record_check?
    
    current_user.authorized_security_for?(current_project, SecuritySetting::READ_WRITE)
  end
  
  def authorized_for_read?
    return true unless existing_record_check?

    current_user.authorized_security_for?(current_project, SecuritySetting::READ_ONLY)
  end

  def authorized_for_destroy?
    return true unless existing_record_check?

    current_user.authorized_security_for?(current_project, SecuritySetting::READ_WRITE_DELETE)
  end
  
  def authorized_for_create?
    true
  end
end