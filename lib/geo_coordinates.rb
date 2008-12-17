class GeoCoordinates
  attr_accessor :longitude, :latitude, :utm_datum, :format

  def initialize(opts)
    opts.each do |k,v|
      self.send("#{k}=", v)
    end
  end

  def format_correct?
    # Did we find what the user said we should find?
    self.data_format.to_s.upcase == self.format
  end

  def decimal_lat_long
    case data_format
    when :utm
      # TODO implement utm to dd conversion
      [ nil, nil ]
    when :dd
      [ self.latitude.to_f, self.longitude.to_f ]
    when :dms
      [ convert_dms_to_dd(self.latitude), convert_dms_to_dd(self.longitude) ]
    end
  end

  def convert_dms_to_dd(value)
    dms = value_to_dms(value)
    return nil if dms.nil?

    partial = (dms[:minutes] * 60 + dms[:seconds]) / 3600
    partial = partial * -1 if dms[:hours] < 0

    dms[:hours] + partial
  end

  def utm_datum_version
    if !self.utm_datum.nil? && self.utm_datum.match(/27/)
      :nad27
    else
      # NAD83 and WGS84 are identical (enough)
      # and if they didn't specify, then we have to pick any ways
      :wgs84
     end
  end

  def utm_zone
    return nil if self.utm_datum.nil?
    match = self.utm_datum.match(/zone\s*(\d{1,2})/i)
    unless match.nil?
      match[0]
    else
      match  = self.utm_datum.match(/^(?:.*\W)?(\d{1,2})\w(\W.*)?$/)
      match[0] unless match.nil?
    end
  end

  def looks_like_utm?
    coords_integers? &&
    self.latitude.to_i > 1000 &&
    self.longitude.to_i > 1000
  end

  def coords_numbers?
    value_is_number?(self.latitude) && value_is_number?(self.longitude)
  end

  def coords_integers?
    value_is_integer?(self.latitude) && value_is_integer?(self.longitude)
  end

  def value_is_integer?(value)
    value_is_number?(value) && value.to_f == value.to_i
  end

  def value_is_number?(value)
    (value.to_f.to_s == value || value.to_i.to_s == value || value.match(/\d+\.\d+e\+\d+/))
  end

  def value_to_dms(value)
    # TODO can we extract the N/S/E/W in order to allow it?
    parts = value.split(/ /)
    return nil unless parts.all? {|p| value_is_number?(p) } && parts.size >= 2

    values = { :hours => parts[0].to_f, :minutes => parts[1].to_f, :seconds => parts[2].to_f }
    return nil unless values[:hours] > -181 && values[:hours] < 181 &&
                      values[:minutes] > 0 && values[:minutes] < 91 &&
                      values[:seconds] > 0 && values[:seconds] < 91

    values
  end

  def data_format
    # Sometimes the user puts in the wrong format
    # so try and figure it out on our own
    if coords_numbers?
      if looks_like_utm?
        # Positive integers on a custom grid
        :utm
      else
        # Decimal geographic numbers
        :dd
      end
    elsif !value_to_dms(self.latitude).nil? && !value_to_dms(self.longitude).nil?
      # Hours Minutes Seconds
      :dms
    end
  end
end
