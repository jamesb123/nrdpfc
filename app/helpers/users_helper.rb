module UsersHelper
  def password_form_column(record, field_name)
    password_field_tag field_name, record.password
  end
  
  def password_confirmation_form_column(record, field_name)
    password_field_tag field_name, record.password_confirmation
  end

  def user_form_column(record, input_name)
    select_tag('record[user][id]', options_for_select(User.find_everybody_but_me.collect{|user| [user.login, user.id]}, record.user_id), {:id => 'record_user_id', :class => 'user-id-input'})
  end

end
