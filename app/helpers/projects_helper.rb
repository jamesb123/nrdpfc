module ProjectsHelper
  def name_column(record)
    output = "#{record.name}"
    output << " <b>(current)</b>" if record == current_project
    output
  end
  
  def security_settings_column(record)
    current_user.authorization_display_for(record)
  end
  
end