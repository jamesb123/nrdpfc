class OrganismsController < ApplicationController
  layout "tabs"
  ORGANISM_BASE_ATTRIBUTE_BEGIN = [:organism_code, :comment]
  # ORGANISM_BASE_ATTRIBUTE_END = [:samples]

  before_filter :add_dynamic_columns
  cattr_accessor :action_links
  
  active_scaffold  :organisms do |config|
    config.columns.exclude :project
    config.columns.exclude :security_settings
    config.columns[:comment].label = "Comments"
  end
  
  def add_dynamic_columns
    organism = Organism.find(:first, :conditions => ["project_id = ?", current_project.id])

    if organism
      dynamic_columns =  organism.dynamic_attributes.map(&:name)
      
      as_reconfigure(:organism, Organism) do | config |
        
        config.columns = OrganismsController::ORGANISM_BASE_ATTRIBUTE_BEGIN + dynamic_columns
        config.actions = 
        for action in [:list, :update, :create]
          c = active_scaffold_config.send(action)
          c.columns = OrganismsController::ORGANISM_BASE_ATTRIBUTE_BEGIN
          c.columns.add dynamic_columns
        end
        
        config.columns.exclude :project
        config.columns.exclude :security_settings
        config.columns[:comment].label = "Comments"
        
        config.actions.add :create, :nested, :update, :search
      end
    end
    
    true
  end
  
  def before_create_save(record)
    record.project_id = current_project.id
  end
  
  #this method returns a where clause given to active_scaffold, plugged into the find :all method for returning Organisms
  def conditions_for_collection
    w = Where.new
    w.and("organisms.project_id = ?", current_project.id)
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
