module SurveysHelper
  def survey_date_column(record)
      record.survey_date.strftime("%Y.%m.%d")
  end
  def survey_time_column(record)
      record.survey_time.strftime("%H:%M:%S")
  end
end
