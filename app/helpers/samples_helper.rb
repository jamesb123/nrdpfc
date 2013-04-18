module SamplesHelper

  def options_for_association_conditions(association)
    if association.name == :organism
      ['project_id = ?', current_project]
    else
      super
    end
  end
# collection_select(object, method, collection, value_method, text_method, options = {}, html_options = {})
# Defined in ActionView::Helpers::FormOptionsHelper

# this works
#  def tissue_type_form_column(record, input_name)
#    collection_select(:record, :tissue_type_id, TissueType.find(:all, :order => 'tissue_desc ASC') , :id, :tissue_desc, {}, {:name=> input_name})
#  end
  
#  def country_form_column(record,input_name)
#    select(record, input_name, state_select(record, input_name))   
#     collection_select(:record, country_select("user", "country_name"))
#  end


  def discrepancy_form_column(record, input_name)
    select_tag(input_name, options_for_select(Sample::DT, record.discrepancy))
  end 

  def date_received_form_column(record, input_name)
    date_select( :record, :date_received, :start_year => 1990, :end_year => 2020, :name => input_name, :include_blank => true )
  end 

#  def date_collected_form_column(record, input_name)
#    date_select :record, :date_collected, :use_month_numbers => true, :start_year => 1899, :end_year => 2020, :name => input_name, :include_blank => true
#  end 

  def shipping_date_form_column(record, input_name)
    date_select :record, :shipping_date,:start_year => 2002, :end_year => 2020, :name => input_name, :include_blank => true
  end 

  def profiling_date_form_column(record, input_name)
    date_select :record, :profiling_date, :start_year => 2002, :end_year => 2020, :name => input_name, :include_blank => true
  end 
  def profile_published_form_column(record,input_name)
    select_tag(input_name,options_for_select(Sample::YNU,record.profile_published))
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
    select_tag(input_name, options_for_select(MM, record.collected_on_month))
  end 
  # year
#  def collected_on_year_form_column(record, input_name)
#    select_tag(input_name, options_for_select(YY, record.collected_on_year))
#  end 
  # day
  def collected_on_day_form_column(record, input_name)
    select_tag(input_name, options_for_select(DD, record.collected_on_day))
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

  def condition_form_column(record, input_name)
    select_tag(input_name, options_for_select(SCAT, record.condition))
  end 

  def age_form_column(record, input_name)
    select_tag(input_name, options_for_select(AGE, record.age))
  end 

  def rehydrated_form_column(record, input_name)
    select_tag(input_name, options_for_select(YN, record.rehydrated))
  end 
  def diet_analysis_form_column(record, input_name)
    select_tag(input_name, options_for_select(YN, record.diet_analysis))
  end 

#  def shippingmaterial_form_column(record, input_name)
#    select_tag(input_name, options_from_collection_for_select(Shippingmaterial.find(:all), 'id', 'medium_short_desc', record.shippingmaterial.to_i))
#  end
#  def storage_medium_form_column(record, input_name)
#    select_tag(input_name, options_from_collection_for_select(Shippingmaterial.find(:all), 'id', 'medium_short_desc', record.storage_medium.to_i  ))
#  end
end

