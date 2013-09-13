class CsvImporter < Struct.new(:data, :model)
  class ParseError < StandardError; end

  IMPORT_TABLES = [ RESULT_TABLES, 'organisms', 'samples' ].flatten

  attr_writer :overwrite
  def overwrite?
    @overwrite == true
  end

  def valid?
    self.import_records(false)
  end

  def import_records(for_real=true)
    records.each_with_index do |row,index|
      line_no = index + 2

      begin
        case model.to_s
        when 'Organism'
          import_organism(row, for_real)
        else
          import_results(row, for_real)
        end
      rescue ParseError => e
        errors << "Line #{line_no} failed: " + e.message
      rescue
        raise $! # TODO for debugging only
        errors << "[FATAL] Line #{line_no} failed: " + $!.message
      end
    end

    errors.empty?
  end

  def import_organism(row, save_record=false)
    sample = Sample.find(row[sample_id_header])
    raise ParseError.new("Invalid/Missing sample id") if sample.nil?

    unless sample.organism.nil?
      raise ParseError.new("Sample ID##{sample.id} already has an #{model}")
    end

    match_on = table_attributes(model, row)
    if match_on['organism_code'].blank?
      raise ParseError.new("Missing organism_code for Sample ID##{sample.id}")
    end

    record = model.find(:first, :conditions => { :organism_code => match_on['organism_code'] })
    if record.nil?
      record = model.new(:project_id => sample.project_id)
      record.attributes = table_attributes(model, row)
      record.attributes = lookup_values(row)
    end

    sample.organism_index = if record.new_record? || record.samples.empty?
      1
    else
      first_existing = record.samples.find(:first, :order => 'organism_index desc')
      first_existing.organism_index.to_i + 1 rescue nil
    end

    sample.organism = record
    sample.attributes = table_attributes(Sample, row).reject do |k,v|
      v.blank? || ![ 'organism_index' ].include?(k)
    end

    unless record.valid?
      raise ParseError.new("#{model} is not valid for sample #{sample.id}: #{record.errors.full_messages.join(',')}")
    end

    unless sample.valid?
      raise ParseError.new("Sample ID##{sample.id} is not valid: #{sample.errors.full_messages.join(',')}")
    end

    if save_record
      record.save! 
      sample.save!
    end
  end
  

  def import_results(row, save_record=false)
    sample = Sample.find(row[sample_id_header])
    raise ParseError.new("Invalid/Missing sample id") if sample.nil?

    record = build_result(sample)
    record.project_id = sample.project_id
    result_values = table_attributes(model, row)
    if result_values.empty?
      raise ParseError.new("Missing values for #{model}")
    end

    record.attributes = result_values
    # record.attributes = lookup_values(row)

    unless record.valid?
      raise ParseError.new("#{model} is not valid for sample #{sample.id}: #{record.errors.full_messages.join(',')}")
    end

    record.save! if save_record
  end

  def has_many?
    HAS_MANY_SAMPLES.include?(model.to_s)
  end

  def build_result(sample)
    record = model.find_by_sample_id(sample.id)
    if record.nil? || overwrite?
      record ||= model.new
    else
      raise ParseError.new("Existing #{model} for sample #{sample.id}")
    end

    record.sample_id = sample.id

    record
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
    tbl = cut_model_name(title)
    return nil if tbl.nil?

    valid = cut_field_name(tbl, title)
    return nil if valid.nil?

    {
      :klass => tbl,
      :field => valid
    }
  end

  def cut_model_name(title)
    Exportables::ExportableModel.models.select do |model|
      title.match(model.exportable_table_name.titleize_with_id)
    end.first
  end

  def cut_field_name(tbl, title)
    tbl.exportable_fields.select do |field|
      title.match(field.titleize_with_id)
    end.first
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
    obj.import_records if obj.valid?

    return obj.errors
  end
end
