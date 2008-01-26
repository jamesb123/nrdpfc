module Exportables::HorizontalExportableModel
  include Exportables::ExportableModel
  
  def self.extended(klass)
    Exportables::ExportableModel.extended(klass)
  end
  
  def exportable_fields
    self.model_for_project(current_project).columns.map(&:name)
  end
  
  def exportable_table_name
    self.table_name_for_project(current_project)
  end
end

