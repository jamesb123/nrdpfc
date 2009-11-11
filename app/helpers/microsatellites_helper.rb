module MicrosatellitesHelper

  def options_for_association_conditions(association)
    if association.name == :locu
      ['locus.project_id = ? AND locus.test_name = ?', current_project, "microsatellite"]
    else
      super
    end
  end
  def approved_form_column(record,input_name)
    if session[:view_approved_data] == true
      select_tag(input_name, options_for_select('False' => 0, 'True' => 1))
    else
      select_tag(input_name, options_for_select('True' => 1, 'False' => 0))
    end
  end

end
