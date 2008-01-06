module Exportables::ExportableModel
  def exportable?
    true
  end
  
  def exportable_columns
    self.columns
  end
  
  def exportable_table_name
    self.table_name
  end
  
  def exportable_table_alias
    self.table_name
  end
  
  def exportable_table_with_alias
    [self.exportable_table_name, self.exportable_table_alias].uniq * " "
  end
  
  def exportable_reflections
    self.reflections.select_hash do |k, v|
      klass = v.class_name.constantize
      klass.respond_to?(:exportable?) && klass.exportable?
    end
  end
  
  def select_sql_for(column_name)
    "`#{exportable_table_alias}`.`#{column_name}` as `#{self.to_s.underscore}_#{column_name}`"
  end
end
