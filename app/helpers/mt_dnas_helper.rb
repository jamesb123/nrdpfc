module MtDnasHelper
  def options_for_association_conditions(association)
    if association.name == :locu
      ['locus.project_id = ? AND locus.test_name = ?', current_project.id, "mtDNA"]
    else
      super
    end
  end

  def date_sequenced_form_column(record, input_name)
    date_select :record, :date_sequenced, :use_month_numbers => true, :start_year => 1899, :end_year => 2020, :name => input_name, :include_blank => true
  end 
  # month
  def month_sequenced_form_column(record, input_name)
    select_tag(input_name, options_for_select(MM, record.collected_on_month))
  end 
  # year
#  def collected_on_year_form_column(record, input_name)
#    select_tag(input_name, options_for_select(YY, record.collected_on_year))
#  end 
  # day
  def day_sequenced_form_column(record, input_name)
    select_tag(input_name, options_for_select(DD, record.collected_on_day))
  end 


end
