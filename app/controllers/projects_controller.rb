class ProjectsController < ApplicationController
  layout "tabs", :except => [:recompile_status, :recompile]

  active_scaffold :projects do |config|
    config.columns = [:name, :owner, :code, :description, :security_setting]  

    # Only project managers can edit their own project...
    config.create.columns.exclude :id, :to_label, :security_setting
    config.update.columns.exclude :id, :to_label, :security_setting
    config.columns[:owner].ui_type = :select
           

    columns[:security_setting].sort_by :method => 'security_setting'
    config.list.sorting = {:security_setting => :asc}
    
     # config.nested.add_link "Samp.", [:samples]
     # config.nested.add_link "Org.", [:organisms]
  end
  
  def conditions_for_collection
    ['projects.user_id = (?) OR EXISTS (SELECT 1 FROM security_settings where security_settings.project_id = projects.id AND security_settings.user_id = ? AND security_settings.level > 0)', current_user.id, current_user.id]
  end
  
  # recompile_status will fire an ajax request to recompile
  def recompile_status
    find_project
  end
  
  def recompile
    find_project
    Compiler.compile_project(@project)
    @project.reload
  end
  
  def update_current_project
    @project = Project.find(params[:current_project_id])
    if @project.authorized_for_read?
      self.current_project = @project
    end
    
    respond_to do |format|
      format.html { 
        redirect_to(params[:redirect_to]) if params[:redirect_to]
      }
      format.js {
        render :update do |page|
          page.redirect_to(params[:redirect_to])
        end
      }
    end
  end
  
protected
  def find_project
    @project = Project.find(params[:id])
  end
end