module HorizontalSharedMethods  
  def self.included(klass)
    # perform basic configuration
    klass.active_scaffold(klass.target_table_name)
    klass.before_filter :set_to_project, :except => [:not_compiled]
    klass.send :extend, HorizontalSharedClassMethods
  end
  
  
  def not_compiled
    return redirect_to(:controller => "message", :action => "no_current_project") unless current_project
    
    @project = current_project
    @model = model_for_current_project
    
    if @model
      redirect_to :action => "index"
      return false
    end
    
    render :template => "shared_horizontal_views/not_compiled"
  end
  
  def set_to_project
    @project_id = current_project_id
    @model = model_for_current_project
    
    if @model == nil
      redirect_to(:action => "not_compiled")
      return false
    end
    
    as_reconfigure(self.class.target_table_name, @model) {|config| 
      # Users are not allowed to update the data directly, and some
      # require model data that doesn't exist for our magic models
      config.actions.exclude :create, :update, :delete, :show

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
