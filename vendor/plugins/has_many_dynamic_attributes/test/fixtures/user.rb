class User < ActiveRecord::Base
  has_many_dynamic_attributes :class_name => 'Preference', :name_field => :key
  has_many_dynamic_attributes :class_name => 'UserContactInfo',
    :foreign_key => :contact_id, :fields => %w(phone aim icq)

  def flex_attributes(model)
    model == Preference ? %w(project_search project_order) : nil
  end
end