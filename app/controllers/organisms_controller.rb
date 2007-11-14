class OrganismsController < ApplicationController
  layout "tabs"
  ORGANISM_BASE_ATTRIBUTE_BEGIN = [:project, :organism_code,  
  :comment, :security_settings ]
  # ORGANISM_BASE_ATTRIBUTE_END = [:samples]

  before_filter :add_dynamic_columns

  active_scaffold  :organisms do |config|
    config.columns = OrganismsController::ORGANISM_BASE_ATTRIBUTE_BEGIN
    config.create.columns.exclude :security_settings
    config.update.columns.exclude :security_settings
  
    config.columns[:comment].label = "Comments"
  end
  
  def add_dynamic_columns
    
    if params[:id]
      organism = Organism.find(params[:id])
    else
      id = params[:eid] || params[:controller]
      session_index = "as:#{id}"
      constraint = session[session_index][:constraints]
    
      #logger.debug("!!!! session dump = #{session[session_index].inspect}")
      #logger.debug("!!!! constraints = #{constraint.inspect}")

      if constraint && constraint[:project]
        organism = Project.find(constraint[:project]).organisms.first
      else
        organism = current_user.current_project.organisms.first
      end
      
    end

    if organism
#      logger.debug("!!!! organism = #{organism.inspect}")
          
      dynamic_columns =  organism.dynamic_attributes.collect {|value| value.name }
#      logger.debug("!!!! dynamic columns = #{dynamic_columns.inspect}")
      active_scaffold_config.columns = OrganismsController::ORGANISM_BASE_ATTRIBUTE_BEGIN
    
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
       'security_settings.user_id = ? AND security_settings.level > 0)) AND (projects.id = ?)', current_user.id, current_user.id, current_user.current_project.id]
    end
  end
      
end
