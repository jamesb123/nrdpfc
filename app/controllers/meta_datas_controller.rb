class MetaDatasController < ApplicationController
  layout "tabs"
 
  active_scaffold :meta_datas do |config|
    config.columns = [:project, :m_name, :m_desc, :m_author, :m_date_added, :m_document_name]
    config.create.columns.exclude :project
    config.update.columns.exclude :project
    config.columns[:m_name].label = "Name"
    config.columns[:m_desc].label = "Desc"
    config.columns[:m_author].label = "Author"
    config.columns[:m_date_added].label = "Date Added"
    config.columns[:m_document_name].label = "Document Name"
    config.columns[:m_date_added].options[:format] = "%y-%m-%d"   
  end
  def conditions_for_collection
    ['meta_datas.project_id = (?)', current_project_id ]
  end

end
