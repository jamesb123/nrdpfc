module MicrosatellitesHelper

  def options_for_association_conditions(association)
    if association.name == :locu
      ['locus.project_id = ? AND locus.test_name = ?', current_project, "microsatellite"]
    else
      super
    end
  end

  def date_genotyped_form_column(record, input_name)
    date_select :record, :date_genotyped, :use_month_numbers => true, :start_year => 1899, :end_year => 2020, :name => input_name, :include_blank => true, :default => nil
  end 

end
