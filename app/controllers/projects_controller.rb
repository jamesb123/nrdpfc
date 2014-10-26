class ProjectsController < ApplicationController
  layout "tabs", :except => [:recompile_status, :recompile]
#  before_filter :check_current_project

  ORG_COLUMNS = [:id, :name, :owner, :code, :description, :security_setting,
    :photo_id_label, :organism_label, :field_ident_label, 
    :opt_col_1, :opt_col_2, :opt_col_3, :opt_col_4, :opt_col_5, 
    :opt_col_6, :opt_col_7, :opt_col_8, :opt_col_9, :opt_col_10, 
    :opt_col_11, :opt_col_12, :opt_col_13, :opt_col_14, :opt_col_15, 
    :opt_col_16, :opt_col_17, :opt_col_18, :opt_col_19, :opt_col_20, 
    :opt_col_21, :opt_col_22, :opt_col_23, :opt_col_24, :opt_col_25]
  PROJ_COLUMNS = [:id, :name, :owner, :code, :description, :security_setting,
    :photo_id_label, :organism_label, :field_ident_label]
    
  active_scaffold :projects do |config|
    config.columns = PROJ_COLUMNS 
    config.columns[:name].set_link 'set_current_project_action', :label => "Set Current", :type => :record, :page => true

    # Only project managers can edit projects
    config.create.columns.exclude :id, :to_label, :security_setting
    config.update.columns.exclude :id, :to_label, :security_setting
    config.columns[:owner].form_ui = :select
           
    columns[:security_setting].sort_by :method => 'security_setting'
    config.list.sorting = {:security_setting => :asc}
    config.columns[:id].label = "ID"
    config.columns[:name].search_sql = 'projects.name'
    config.search.columns << :name
  end
  
  def conditions_for_collection
    ['(projects.user_id = (?) OR EXISTS (SELECT 1 FROM security_settings where security_settings.project_id = projects.id AND security_settings.user_id = ? AND security_settings.level > 0))', current_user.id, current_user.id]
  end
  
def check_current_project
    # they forget so force a compile of derived ms tables
    if current_project.recompile_required  
      recompile
    end
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

  def set_current_project_action
    @project = Project.find(params[:id])
    if @project.authorized_for_read?
      self.current_project = @project
    end
    # they forget so force a compile of derived ms tables
    # if @project.recompile_required  
    #  recompile
    # end
 
    url = url_for(:controller => 'projects')

    respond_to do |format|
      format.html { 
      redirect_to(url)
      }
      format.js {
        render :update do |page|
          page.redirect_to(url)
        end
      }
    end
  end


  def update_current_project
    @project = Project.find(params[:current_project_id])
    if @project.authorized_for_read?
      self.current_project = @project
    end
    # they forget so force a compile of derived ms tables
    if @project.recompile_required  
      recompile
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
#    @project = Project.find(params[:id])
    @project = Project.find(current_project.id)
  end
end
