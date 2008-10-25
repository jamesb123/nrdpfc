module DnaResultsHelper
  def record_select_conditions_from_controller
    ['project_id = ?', current_project]
  end
  def options_for_association_conditions(association)
    if association.name == :sample
      ['project_id = ?', current_project]
    else
      super
    end
  end

#  def extraction_date_form_column(record, input_name)
#    date_select :record, :extraction_date, :name => input_name, :include_blank => true
#  end 

end
