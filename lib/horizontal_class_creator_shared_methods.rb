module HorizontalClassCreatorSharedMethods
  def model_for_project(project_id)
    project_id = project_id.id if Project === project_id
    table_name = table_name_for_project(project_id)
    
    return nil unless table_name_exists?(table_name)
    
    model = Class.new(self)
    model.table_name = table_name
    
    model
  end
  
  def table_name_exists?(table_name)
    connection.select_values("show tables").include?(table_name)
  end
  
  
  def column_names
    @column_names||=self.columns.map(&:name)
  end
  
  def dynamic_column_names
    @dynamic_column_names ||= column_names - non_dynamic_columns_names
  end
end