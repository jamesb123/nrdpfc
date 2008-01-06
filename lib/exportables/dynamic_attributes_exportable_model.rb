module Exportables::DynamicAttributesExportableModel
  include Exportables::ExportableModel
  
  def exportable_fields
    self.model_for_project(current_project).columns.map{|c| c.name}
  end
  
  def exportable_table_name
    self.table_name
  end
  
  def exportable_fields
    self.model_for_project(current_project).columns.map{|c| c.name}
  end
  
  def dynamic_attributes
    DynamicAttribute.find(:all, :conditions => {:scoper_type => "Project", :scoper_id => current_project.id, :owner_type => self.class.to_s})
  end
  
  def dynamic_attribute_names
    dynamic_attributes.map(&:name)
  end
  
  def dynamic_types
    dynamic_attributes.map(&:dynamic_type).map(&:name)
  end
  
  alias :select_sql_for_super :select_sql_for
  def select_sql_for(column_name)
    if dynamic_attribute_names.include?(column_name)
      # TODO - handle crosstabbing
    else
      # get directly
      select_sql_for_super(column_name)
    end
  end
end

