module SurveysHelper
#  def survey_time_form_column(record, input_name)
#    time_select( :record, :survey_time, :name => input_name, :include_blank => true )
#  end 
  def survey_date_column(record)
      record.survey_date.strftime("%Y.%m.%d")
  end
  def survey_time_column(record)
      record.survey_time.strftime("%H:%M:%S")
  end
end
