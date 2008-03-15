class OrganismsController < ApplicationController
  layout "tabs"
  ORGANISM_BASE_ATTRIBUTE_BEGIN = [:id, :organism_code, :comment, :samples]
  # ORGANISM_BASE_ATTRIBUTE_END = [:samples]

  before_filter :add_dynamic_columns
  cattr_accessor :action_links
  
  active_scaffold  :organisms do |config|
    list.sorting = {:organism_code => 'ASC'}  
    config.columns[:id].label = "ID"
    config.create.columns.exclude :id, :project, :security_settings
    config.update.columns.exclude :id, :project, :security_settings
    config.columns[:comment].label = "Comments"
    config.columns = [:id, :organism_code, :comment, :samples]
  end
  
  def add_dynamic_columns
    organism = Organism.find(:first, :conditions => ["project_id = ?", current_project.id])
    c = active_scaffold_config
    
    for cp in [c.list, c.update, c.create, c]
      columns_for_deletion = (cp.columns.map(&:name).map(&:to_sym) - Organism.columns.map(&:name).map(&:to_sym))
      cp.columns.exclude *columns_for_deletion
      
      if organism
        dynamic_columns ||= organism.dynamic_attributes.map(&:name)
        cp.columns.add dynamic_columns
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
