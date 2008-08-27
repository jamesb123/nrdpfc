module QueryHelper
  def query_field_id_prefix(query_field)
    "#{query_field.table.name}_#{query_field.index.to_s.rjust(3, '0')}_#{query_field.name}"
  end
end
