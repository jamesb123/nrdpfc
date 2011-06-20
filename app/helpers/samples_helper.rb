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

#  def tissue_type_form_column(record, input_name)
#    select_tag(input_name, options_for_select([['Unknown','unknown'], ['Fin Clip','fin clip']]))
#  end

# this one
#  def tissue_type_form_column(record, input_name)
#    collection_select(:record, :tissue_type_id, TissueType.find(:all, :order => 'tissue_desc ASC') , :id, :tissue_desc, {}, {:name=> input_name})
#    collection_select(:record, :tissue_type_id, TissueType.find(:all, :order => 'tissue_desc ASC') , :id, :tissue_desc, {}, {:name=> input_name})
##    @tt = params[:record][:tissue_type]
# RAILS_DEFAULT_LOGGER.debug @tt    
#  end

# ************* 
# this works
# ************
#  def tissue_type_form_column(record, input_name)
#    select_tag(input_name, options_for_select([ ['Unknown', 'Unknown'], ['Fin Clip', 'Fin Clip'], ['Hair', 'Hair'], ['Skin', 'Skin'], ['Blood','Blood'],['Bone','Bone'],['Heart','Heart'],['Kidney','Kidney'],['','']], record.tissue_type)) 
#  end

# alltissuetypes = Array.new
# alltisuetypes = TissueType.find(:all )

#  def tissue_type_form_column(record, input_name)
# puts @alltissuetypes
#    select_tag( input_name, options_from_collection_for_select(@alltissuetypes, 'id', 'to_label', record.tissue_type ))
#  end
    
#    select_tag(input_name, options_from_collection_for_select( TissueType.find(:all), :id,:tissue_type),record.tissue_type) 

  
#  def country_form_column(record,input_name)
#    select(record, input_name, state_select(record, input_name))   
#     collection_select(:record, country_select("user", "country_name"))
#  end

  def date_received_form_column(record, input_name)
    date_select( :record, :date_received, :name => input_name, :include_blank => true )
  end 

  def date_collected_form_column(record, input_name)
    date_select :record, :date_collected, :name => input_name, :include_blank => true
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

