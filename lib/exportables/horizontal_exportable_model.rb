module Exportables::HorizontalExportableModel
  include Exportables::ExportableModel
  
  def exportable_fields
    self.model_for_project(current_project).columns.map{|c| c.name}
  end
  
  def exportable_table_name
    self.table_name_for_project(current_project)
  end
  
  def exportable_fields
    self.model_for_project(current_project).columns.map{|c| c.name}
  end
end

