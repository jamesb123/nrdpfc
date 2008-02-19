class SampleNonTissuesController < ApplicationController
  layout "tabs"
  SNT_BASE_ATTRIBUTE = [:id, :project, :field_code, :prov, :security_settings ]

   before_filter :add_dynamic_columns
  # before_filter :login_required
  
  active_scaffold :sample_non_tissues do |config|
  
    config.columns = SampleNonTissuesController::SNT_BASE_ATTRIBUTE
    list.sorting = {:field_code => 'ASC'}  
#    config.list.columns.exclude :id, :project, :security_settings
    config.create.columns.exclude :id, :project, :security_settings
    config.update.columns.exclude :id, :project, :security_settings
    
    # config.columns[:sample_non_tissue_code].label = "Org."
  end  

  def add_dynamic_columns
    
    if params[:id]
      sample_non_tissue = SampleNonTissue.find(params[:id])
    else
      id = params[:eid] || params[:controller]
      session_index = "as:#{id}"
      constraint = session[session_index][:constraints]
    
      #logger.debug("!!!! session dump = #{session[session_index].inspect}")
      #logger.debug("!!!! constraints = #{constraint.inspect}")

      if constraint && constraint[:project]
        sample_non_tissue = Project.find(constraint[:project]).sample_non_tissues.first
      else
        sample_non_tissue = current_project.sample_non_tissues.first
      end
      
    end
    if sample_non_tissue
#      logger.debug("!!!! sample_non_tissue = #{sample_non_tissue.inspect}")
          
      dynamic_columns =  sample_non_tissue.dynamic_attributes.collect {|value| value.name }
#      logger.debug("!!!! dynamic columns = #{dynamic_columns.inspect}")
      active_scaffold_config.columns = SampleNonTissuesController::SNT_BASE_ATTRIBUTE
    
      active_scaffold_config.list.columns.add dynamic_columns
      active_scaffold_config.update.columns.add dynamic_columns
      active_scaffold_config.create.columns.add dynamic_columns
    end

  end
  
  #this method returns a where clause given to active_scaffold, plugged into the find :all method for returning Organisms
  def conditions_for_collection
    if params[:id]
      ['(projects.user_id = (?) OR EXISTS (SELECT 1 FROM security_settings where security_settings.project_id = projects.id AND ' + 
       'security_settings.user_id = ? AND security_settings.level > 0))', current_user.id, current_user.id]
    else
      ['(projects.user_id = (?) OR EXISTS (SELECT 1 FROM security_settings where security_settings.project_id = projects.id AND ' + 
       'security_settings.user_id = ? AND security_settings.level > 0)) AND (projects.id = ?)', current_user.id, current_user.id, current_project.id]
    end
  end
      
end  

