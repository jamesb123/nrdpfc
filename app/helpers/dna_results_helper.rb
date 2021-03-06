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

  def extraction_date_form_column(record, input_name)
    date_select :record, :extraction_date, :name => input_name, :start_year => 1985, :end_year => 2020, :include_blank => true, :default => nil
  end 
end
