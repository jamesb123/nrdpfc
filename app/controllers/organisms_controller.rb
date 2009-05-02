class OrganismsController < ApplicationController
  layout "tabs"
  ORGANISM_BASE_ATTRIBUTE_BEGIN = [:id, :organism_code, :comment, :samples]
  # ORGANISM_BASE_ATTRIBUTE_END = [:samples]
  include GoToOrganismCode::Controller

  before_filter :add_dynamic_columns
  cattr_accessor :action_links
  
  active_scaffold  :organisms do |config|
    config.columns = [:id, :organism_code, :comment, :samples, :dynamic_attribute_values ]
    config.list.columns.exclude :dynamic_attribute_values
    config.create.columns.exclude :id, :project, :security_settings, :dynamic_attribute_values
    config.update.columns.exclude :id, :project, :security_settings, :dynamic_attribute_values
    config.show.columns.exclude :dynamic_attribute_values

    config.columns[:organism_code].label = "Organism"
    config.columns[:comment].label = "Comments"
    config.columns[:organism_code].sort_by :sql => 'organisms.organism_code'
    config.nested.add_link("Samples", [:samples])

    config.search.columns << :dynamic_attribute_values
    config.columns[:dynamic_attribute_values].search_sql = 'dynamic_attribute_values.text_value'
    config.columns[:dynamic_attribute_values].includes = [ 'dynamic_attribute_values' ]
  end

  def dummy_organism
    @dummy ||= Organism.find(:first, :conditions => ["project_id = ?", current_project_id])
  end
  
  def add_dynamic_columns
    return if dummy_organism.nil?

    organism_columns = Organism.columns.map(&:name).map(&:to_sym)
    dynamic_columns = dummy_organism.dynamic_attributes.map(&:name)
    c = active_scaffold_config
    
    for cp in [c.list, c.update, c.create, c]
      existing = cp.columns.map(&:name).map(&:to_sym)
      columns_for_deletion = existing - organism_columns

      cp.columns.exclude *columns_for_deletion
      cp.columns.add dynamic_columns
    end

    dummy_organism.dynamic_attributes.each do |col|
      col_field = col.dynamic_type.stored_in_field
      c.columns[col.name].sort_by :sql => "dynamic_attribute_values.#{col_field}"
    end
    
    true
  end

  def joins_for_collection
    "dynamic_attribute_values" if sorting_dynamic_attribute
  end

  def sorting_dynamic_attribute
    return nil if params[:sort].nil? || dummy_organism.nil?
    @sorting_attribute ||= dummy_organism.dynamic_attributes.
                             select {|d| d.name == params[:sort] }[0]
  end
  
  def before_create_save(record)
    record.project_id = current_project_id
  end
  
  # this method returns a where clause given to active_scaffold,
  # plugged into the find :all method for returning Organisms
  def conditions_for_collection
    w = Where.new
    w.and("organisms.project_id = ?", current_project_id)

    if sorting_dynamic_attribute
      w.and('dynamic_attribute_values.dynamic_attribute_id = ?', sorting_dynamic_attribute.id)
    end
    w.to_s
  end
end
