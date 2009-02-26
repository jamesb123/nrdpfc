module SamplesHelper
  def columns_per_section(section)
    (section == 'fixed' ? (0..3) : (4..100)).to_a
  end

  def row_wrapper_style
    "height:15px;overflow:hidden;"
  end

  def header_wrapper_style
    "height:50px;overflow:hidden;"
  end

  def options_for_association_conditions(association)
    if association.name == :organism
      ['project_id = ?', current_project]
    else
      super
    end
  end

  def date_received_form_column(record, input_name)
    date_select :record, :date_received, :name => input_name, :include_blank => true
  end 

  def date_collected_form_column(record, input_name)
    date_select :record, :date_collected, :name => input_name, :include_blank => true
  end 

  def type_lat_long_form_column(record, input_name)
    select_tag(input_name, options_for_select([ ['', ''], ['DD (Decimal)', 'DD'], ['DMS (Hours Min Sec)', 'DMS'], ['UTM (Zone Coordinates)', 'UTM'] ], record.type_lat_long))
  end

  def location_measurement_method_form_column(record, input_name)
    select_tag(input_name, options_for_select([ ['', ''], ['Random', 'Random'], ['Measured', 'Measured'], ['Centroid', 'Centroid'] ], record.type_lat_long))
  end 

  # month
  def collected_on_month_form_column(record, input_name)
    select_tag(input_name, options_for_select([  ['', ''], ['January', 'January'], ['February', 'February'], ['March', 'March'], ['April','April'] , ['May','May'] , ['June','June'] , ['July','July'] , ['August','August'] , ['September','September'] , ['October','October'] , ['November','November'] , ['December','December'] ], record.type_lat_long))
  end 

  # day
#  def collected_on_day_form_column(record, input_name)
#    select_day(record[:collected_on_day], :prefix => input_name, :include_blank => true)
#  end

#  def collected_on_year_form_column(record, input_name)
#    select_year( record[:collected_on_year], :name=>input_name, :include_blank => true)
#    if record.collected_on_year.nil?
#      record.collected_on_year = '&nbsp' 
#    end
#  end
  


#   record.date_collected ||= Time.now.year
#   select(:record, :date_collected, Time.now.year - 15..Time.now.year + 15,
#{:include_blank => false, :selected => Time.now.year}, {:name =>
#input_name})

#  def date_collected_form_column(record, input_name)
    # with date_select we can use :name
#    date_select :record, :date_collected, :name => input_name
    # but if we used select_date we would have to use :prefix
    #select_date record[:date_received], :prefix => input_name
#  end  
  
end

