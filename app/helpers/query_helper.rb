module QueryHelper
  def query_field_id_prefix(query_field)
    "#{query_field.table.name}_#{query_field.index.to_s.rjust(3, '0')}_#{query_field.name.to_s.downcase}"
  end

  def georss_description(query_builder, result)
    query_builder.select_field_aliases.collect do |select_field_alias|
      if !select_field_alias.match(/_true_\w+$/)
        "#{select_field_alias.titleize_with_id}: #{result[select_field_alias]}" 
      end
    end.compact.join("<br/>\n")
  end

  def georss_long_lat(xml, result)
    result.each do |k,v|
      xml.geo :long, v if k.match(/true_longitude/)
      xml.geo :lat, v if k.match(/true_latitude/)
    end
  end

  def filter_value_form_column
    input_name = "data[#{@query_table.name}][#{@query_field.name}][filters][value][]"

    if data = picklist_field(@query_table, @query_field.name.to_s, input_name)
      data
    else
      text_field_tag input_name, ""
    end
  end

  def picklist_field(table, field, name)
    picklists = %w( project_id extraction_method_id extraction_method
      shippingmaterial_id locality_type locality_type_id
      tissue_type tissue_type_id locus locu_id storage_medium
      storage_medium_id)

    if picklists.include?(field)
      related = picklist_column(table, field)
      return nil if related.nil?

      is_id = field.to_s.match(/_id/)
      options = options_from_collection_for_select(related.all,
                                (is_id ? 'id' : 'to_label'), 'to_label')

      select_tag(name, options)
    end
  end

  def picklist_column(table, field)
    if match = field.match(/(.+?)_id/)
      # Auto picklist associations
      assoc = table.model.reflections[match[1].intern]
      return assoc.klass unless assoc.nil?
    else
      related = Object.const_get(field.camelcase) rescue nil
      return related unless related.nil?
    end
  end
end
