module SsamplesHelper

  def options_for_association_conditions(association)
    if association.name == :organism
      ['project_id = ?', current_project]
    else
      super
    end
  end
  def discrepancy_form_column(record, input_name)
    select_tag(input_name, options_for_select(Sample::DT, record.discrepancy))
  end 

  def date_received_form_column(record, input_name)
    date_select( :record, :date_received, :name => input_name, :include_blank => true )
  end 

  def date_collected_form_column(record, input_name)
    date_select :record, :date_collected, :name => input_name, :include_blank => true
  end 

  def shipping_date_form_column(record, input_name)
    date_select :record, :shipping_date, :name => input_name, :include_blank => true
  end 
  def profiling_date_form_column(record, input_name)
    date_select :record, :profiling_date, :name => input_name, :include_blank => true
  end 

  def type_lat_long_form_column(record, input_name)
    select_tag(input_name, options_for_select([ ['', ''], ['DD (Decimal)', 'DD'], 
    ['DMS (Hours Min Sec)', 'DMS'], ['UTM (Zone Coordinates)', 'UTM'] ], record.type_lat_long))
  end

  def locality_type_method_form_column(record, input_name)
    select_tag(input_name, options_for_select([ ['', ''], ['Random', 
    'Random'], ['Measured', 'Measured'], ['Centroid', 'Centroid'] ], record.locality_type))
  end 

  # month
  def collected_on_month_form_column(record, input_name)
    select_tag(input_name, options_for_select([  ['', ''], 
    ['January', 'January'], ['February', 'February'], ['March', 
    'March'], ['April','April'] , ['May','May'] , ['June','June'] , 
    ['July','July'] , ['August','August'] , ['September','September'] , 
    ['October','October'] , ['November','November'] , ['December',
    'December'] ], record.collected_on_month))
  end 

  def location_accuracy_form_column(record, input_name)
    select_tag(input_name, 
    options_for_select([  ['', ''], ['Very Accurate (to 2m)', 
    'Very Accurate (to 2m)'], ['Accurate (to 10m)', 'Accurate (to 10m)'], 
    ['Reliable (to 100m)', 'Reliable (to 100m)'], ['Approximate (to 500m)', 
    'Approximate (to 500m)'], ['Moderate (to 1000m)', 'Moderate (to 1000m)'], 
    ['General (to 10,000m)', 'General (to 10,000m)'], ['Vague (to 100,000m)', 
    'Vague (to 100,000m)'] ], record.location_accuracy))
  end
  

  def location_measurement_method_form_column(record, input_name)
    select_tag(input_name, options_for_select([ ['', ''],
    ['Random', 'Random'], ['Measured', 'Measured'], ['Centroid',
    'Centroid'] ], record.location_measurement_method))
  end 

end

