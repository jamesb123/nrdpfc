module SecuritySettingsHelper
  
  def level_form_column(record, input_name)
    select_tag(input_name, options_for_select(SecuritySetting::LEVELS, record.level_option_for_select_selected))
  end
  
end