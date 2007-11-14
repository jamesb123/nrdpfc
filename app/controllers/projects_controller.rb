class ProjectsController < ApplicationController
  layout "tabs"
#  before_filter :login_required

  active_scaffold :projects do |config|
    config.columns = [:id, :name, :owner,:code, :description,  :security_setting]  
           
    config.create.columns.exclude :id, :to_label, :security_setting, :owner
    config.update.columns.exclude :id, :to_label, :security_setting, :owner

    columns[:security_setting].sort_by :method => 'security_setting'
    config.list.sorting = {:security_setting => :asc}
    
     # config.nested.add_link "Samp.", [:samples]
     # config.nested.add_link "Org.", [:organisms]
  end
  
  def conditions_for_collection
    ['projects.user_id = (?) OR EXISTS (SELECT 1 FROM security_settings where security_settings.project_id = projects.id AND security_settings.user_id = ? AND security_settings.level > 0)', current_user.id, current_user.id]
  end
  
end