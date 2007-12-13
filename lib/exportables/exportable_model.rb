module ExportableModel
  def exportable?
    true
  end
  
  def exportable_fields
    self.columns.map{|c| c.name}
  end
  
  def exportable_table_name
    self.table_name
  end
end