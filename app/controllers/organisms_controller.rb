class OrganismsController < ApplicationController
  layout "tabs"
  ORGANISM_BASE_ATTRIBUTE_BEGIN = [:project, :organism_code, :comment, :security_settings ]
  # ORGANISM_BASE_ATTRIBUTE_END = [:samples]

  before_filter :add_dynamic_columns

  active_scaffold  :organisms do |config|
    config.columns = OrganismsController::ORGANISM_BASE_ATTRIBUTE_BEGIN
    config.columns.exclude :project
    config.create.columns.exclude :security_settings
    config.update.columns.exclude :security_settings
  
    config.columns[:comment].label = "Comments"
  end
  
  def add_dynamic_columns
    organism = Organism.find(:first, :conditions => ["project_id = ?", current_project.id])

    if organism
      dynamic_columns =  organism.dynamic_attributes.collect {|value| value.name }
      active_scaffold_config.columns = OrganismsController::ORGANISM_BASE_ATTRIBUTE_BEGIN
    
      active_scaffold_config.list.columns.add dynamic_columns
      active_scaffold_config.update.columns.add dynamic_columns
      active_scaffold_config.create.columns.add dynamic_columns
    end
  end
  
  def before_create_save(record)
    record.project_id = current_project.id
  end
  
  #this method returns a where clause given to active_scaffold, plugged into the find :all method for returning Organisms
  def conditions_for_collection
    w = Where.new
    w.and("project_id = ?", current_project.id)
    # if params[:id]
    #   ['(projects.user_id = (?) OR EXISTS (SELECT 1 FROM security_settings where security_settings.project_id = projects.id AND ' + 
    #    'security_settings.user_id = ? AND security_settings.level > 0))', current_user.id, current_user.id]
    # else
      # ['(projects.user_id = (?) OR EXISTS (SELECT 1 FROM security_settings where security_settings.project_id = projects.id AND ' + 
      #  'security_settings.user_id = ? AND security_settings.level > 0)) AND (projects.id = ?)', current_user.id, current_user.id, current_project.id]
    # end
    w.to_s
  end
end
