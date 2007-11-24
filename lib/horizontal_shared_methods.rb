module HorizontalSharedMethods  
  def self.included(klass)
    # perform basic configuration
    klass.active_scaffold(klass.target_table_name)
    klass.before_filter :set_to_project, :except => [:not_compiled]
    klass.send :extend, HorizontalSharedClassMethods
  end
  
  
  def not_compiled
    @project = current_project
    @model = model_for_current_project
    redirect_to :action => "index" if @model
  end
  
  def set_to_project
    @project_id = current_project.id
    @model = model_for_current_project
    
    if @model == nil
      redirect_to(:action => "shared_horizontal/not_compiled")
      return false
    end
    
    as_reconfigure(self.class.target_table_name, @model) {|config| 
      custom_reconfiguration(config)
    }
    true
  end
  
  def list_authorized?
    true
  end
protected
  
  def model_for_current_project
    self.class.target_model_name.constantize.model_for_project(current_project)

  end

  module HorizontalSharedClassMethods
    def target_model_name
      self.target_table_name.to_s.classify
    end
  end
end