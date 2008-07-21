module SamplesHelper
  def options_for_association_conditions(association)
    if association.name == :organism
      ['project_id = ?', current_project]
    else
      super
    end
  end

  def collected_on_month_form_column(record, input_name)
    select_month( record[:collected_on_month], :name=>input_name, :include_blank => true)
#    if record.collected_on_month.nil?
#      record.collected_on_month = '&nbsp' 
#    end
  end
  def collected_on_day_form_column(record, input_name)
    select_day( record[:collected_on_day], :name=>input_name, :include_blank => true)
#    if record.collected_on_day.nil?
#      record.collected_on_day = '&nbsp' 
#    end
  end
  def collected_on_year_form_column(record, input_name)
    select_year( record[:collected_on_year], :name=>input_name, :include_blank => true)
#    if record.collected_on_year.nil?
#      record.collected_on_year = '&nbsp' 
#    end
  end
  
  # date_select(:record, :date_collected,  :include_blank => true)
  #    date_select(:record, :date_collected, :name => '')
  

def date_collected_form_column(record, input_name)
   record.date_collected ||= Time.now.year
#   select(:record, :date_collected, Time.now.year - 15..Time.now.year + 15,
#{:include_blank => false, :selected => Time.now.year}, {:name =>
#input_name})
end 

#  def date_collected_form_column(record, input_name)
    # with date_select we can use :name
#    date_select :record, :date_collected, :name => input_name
    # but if we used select_date we would have to use :prefix
    #select_date record[:date_received], :prefix => input_name
#  end  
  
end

