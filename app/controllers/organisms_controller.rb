class OrganismsController < ApplicationController
  layout "tabs"
  
  ORGANISM_BASE_ATTRIBUTE_BEGIN = [:id, :organism_code, :comment, :samples, :approved]
  # ORGANISM_BASE_ATTRIBUTE_END = [:samples]

  before_filter :add_dynamic_columns
  cattr_accessor :action_links
  
  active_scaffold  :organisms do |config|
    config.columns = [:id, :organism_code, :comment, :samples, :approved]
    config.create.columns.exclude :id, :project, :security_settings
    config.update.columns.exclude :id, :project, :security_settings
    config.columns[:organism_code].label = "Organism"
    config.columns[:comment].label = "Comments"
    config.columns[:organism_code].sort_by :sql => 'organisms.organism_code'
    
    config.nested.add_link("Samples", [:samples])
  end

  include ApprovedDataOnly
  include GoToOrganismCode::Controller

  def add_dynamic_columns
    organism = Organism.find(:first, :conditions => ["project_id = ?", current_project_id])
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
end
