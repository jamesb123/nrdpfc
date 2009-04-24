class GeoCoordinates
  attr_accessor :longitude, :latitude, :coordinate_system, :format

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
      values = [ latitude_number, longitude_number ]

      valid_decimal_range?(values[0]) &&
      valid_decimal_range?(values[1]) ? values : [ nil, nil ]
    when :dms
      [ convert_dms_to_dd(self.latitude), convert_dms_to_dd(self.longitude) ]
    end
  end

  def convert_dms_to_dd(value)
    dms = value_to_dms(value)
    return nil if dms.nil?

    partial = (dms[:minutes] * 60 + dms[:seconds]) / 3600
    partial = partial * -1 if dms[:hours] < 0
    number = dms[:hours] + partial

    valid_decimal_range?(number) ? number : nil
  end

  def coordinate_system_version
    if !self.coordinate_system.nil? && self.coordinate_system.match(/27/)
      :nad27
    else
      # NAD83 and WGS84 are identical (enough)
      # and if they didn't specify, then we have to pick any ways
      :wgs84
     end
  end

  def utm_zone
    return nil if self.coordinate_system.nil?
    match = self.coordinate_system.match(/zone\s*(\d{1,2})/i)
    unless match.nil?
      match[0]
    else
      match  = self.coordinate_system.match(/^(?:.*\W)?(\d{1,2})\w(\W.*)?$/)
      match[0] unless match.nil?
    end
  end

  def looks_like_utm?
    coords_integers? &&
    1000 < self.latitude.to_i  && self.latitude.to_i  < 10000001 &&
    1000 < self.longitude.to_i && self.longitude.to_i < 10000001
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
    (value.match(/[-]?\d+(\.\d+)?/) || value.to_f.to_s == value || value.to_i.to_s == value || value.match(/\d+\.\d+e\+\d+/))
  end

  def valid_decimal_range?(value)
    -181 < value && value < 181
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

  def longitude_number
    BigDecimal.new(self.longitude).to_f
  end

  def latitude_number
    BigDecimal.new(self.latitude).to_f
  end

  def data_format
    # Sometimes the user puts in the wrong format
    # so try and figure it out on our own
    if coords_numbers?
      if looks_like_utm?
        # Positive integers on a custom grid
        :utm
      elsif valid_decimal_range?(latitude_number) && valid_decimal_range?(longitude_number)
        # Decimal geographic numbers
        :dd
      end
    elsif !value_to_dms(self.latitude).nil? && !value_to_dms(self.longitude).nil?
      # Hours Minutes Seconds
      :dms
    end
  end
end
