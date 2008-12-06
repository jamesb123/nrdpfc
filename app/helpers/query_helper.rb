module QueryHelper
  def query_field_id_prefix(query_field)
    "#{query_field.table.name}_#{query_field.index.to_s.rjust(3, '0')}_#{query_field.name.to_s.downcase}"
  end

  def georss_description(query_builder, result)
    query_builder.select_field_aliases.collect do |select_field_alias|
      "#{select_field_alias.titleize_with_id}: #{result[select_field_alias]}"
    end.join("\n")
  end

  def georss_long_lat(xml, result)
    result.each do |k,v|
      xml.geo :long, v if k.match(/longitude/)
      xml.geo :lat, v if k.match(/latitude/)
    end
  end
end
