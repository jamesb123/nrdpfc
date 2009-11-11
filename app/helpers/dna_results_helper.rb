module DnaResultsHelper
  def record_select_conditions_from_controller
    ['project_id = ?', 1]
  end
  def options_for_association_conditions(association)
    if association.name == :sample
      ['project_id = ?', current_project]
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

#  def extraction_date_form_column(record, input_name)
#    date_select :record, :extraction_date, :name => input_name, :include_blank => true
#  end 

end
