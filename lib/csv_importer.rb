class CsvImporter < Struct.new(:data, :model)
  class ParseError < StandardError; end

  attr_writer :overwrite
  def overwrite?
    @overwrite == true
  end

  def import_records(for_real=false)
    records.each_with_index do |row,index|
      line_no = index + 1 

      begin
        import_sample(row, for_real)
      rescue ParseError => e
        errors << "Line #{line_no} failed: " + e.message
      rescue
        raise $! # TODO for debugging only
        errors << "[FATAL] Line #{line_no} failed: " + $!.message
      end
    end

    errors.empty?
  end

  def import_sample(row, save_record=false)
    sample = Sample.find(row[sample_id_header])
    raise ParseError.new("Invalid/Missing sample id") if sample.nil?

    record = model.find_by_sample_id(sample.id)
    if record.nil? || overwrite?
      record ||= model.new
    else
      raise ParseError.new("Existing #{model} for sample #{sample.id}")
    end

    record.sample_id = sample.id
    record.project_id = sample.project_id
    record.attributes = table_attributes(model, row)
    record.attributes = lookup_values(row)

    unless record.valid?
      raise ParseError.new("#{model} is not valid for sample #{sample.id}: #{record.errors.full_messages.join(',')}")
    end

    record.save! if save_record
  end

  def lookup_values(row)
    attrs = {}

    included_models.each do |klass|
      next unless lookups.include?(klass)

      match_on = table_attributes(klass, row)
      next if match_on.empty?

      related = klass.find(:first, :conditions => match_on)
      if related.nil?
        msg = "Failed to find #{klass} with "
        msg << match_on.collect do |k,v|
          "#{k}=#{v}"
        end.join(',')
        raise ParseError.new(msg)
      end

      attrs[klass.to_s.underscore] = related
    end

    attrs
  end

  def lookups
    model.reflections.map {|k,v| v.klass }.delete_if {|m| [ Sample, Project ].include?(m) }
  end

  def table_attributes(klass, row)
    attrs = {}

    mapped_headers.each do |k,v|
      value = row[k]
      attrs[v[:field]] = value if v[:klass] == klass and !value.blank?
    end

    attrs
  end

  def mapped_headers
    return @mapped_headers unless @mapped_headers.nil?
    @mapped_headers = {}

    headers.each do |head|
      value = map_header(head)
      @mapped_headers[head] = value unless value.nil?
    end

    @mapped_headers
  end

  def included_models
    mapped_headers.collect {|k,v| v[:klass] }.uniq
  end

  def sample_id_header
    "Samples Id"
  end

  def field_header(klass, field)
    mapped_headers.each do |k,v|
      return k if v &&
                  v[:klass] == klass &&
                  v[:field] == field
    end
  end

  def map_header(title)
    tbl_name, field_name = title.split(' ', 2)
    tbl = klass_by_title(tbl_name)
    return nil if tbl.nil?

    valid = tbl.exportable_fields.select do |field|
      field.titleize_with_id == field_name
    end
    return nil if valid.empty?

    {
      :klass => tbl,
      :field => valid[0]
    }
  end

  def klass_by_title(name)
    tbl = Object.const_get(name.singularize)
    return tbl if tbl.superclass == ActiveRecord::Base
  end

  def headers
    records[0].headers
  end

  def fastercsv_options
    {
      :col_sep => ',',
      :headers => true,
      :return_headers => false
    }
  end

  def errors
    @errors ||= []
  end

  def records
    @csv_records ||= FasterCSV.parse(data, fastercsv_options)
  end

  def self.import(data, model)
    obj = new(data, model)
    obj.import_records(true) if obj.import_records

    return obj.errors
  end
end
