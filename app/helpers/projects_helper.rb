module ProjectsHelper
  
  def security_settings_column(record)
    current_user.authorization_display_for(record)
  end
  
end