module SightingsHelper
  def sighting_date_column(record)
      record.sighting_date.strftime("%Y.%m.%d")
  end
  def sighting_time_column(record)
      record.sighting_time.strftime("%H:%M:%S")
  end
end