module CurrentProjectHelper
  def self.included(base)
    base.helper_method :current_project=, :current_project, :current_project_id
    base.prepend_before_filter :assign_current_project_to_models
  end
  
  def assign_current_project_to_models
    ActiveRecord::Base.current_project_proc = proc { current_project }
  end
  
  def current_project=(project)
    project_id = project.is_a?(Project) ? project.id : project
    
    session[:project_id] = project_id
  end
  
  def current_project
    return @current_project if @current_project
    current_project_id = session[:project_id]
    if current_project_id
      @current_project = Project.find(current_project_id)
    else
      @current_project = current_user.default_project || Project.current_users_accessible_projects.first
    end
  end
  
  def current_project_id
    current_project && current_project.id
  end
  
  module ActiveRecordHelpers
    module ClassMethods
      attr_accessor :current_project_proc

      def current_project
        ActiveRecord::Base.current_project_proc.call if ActiveRecord::Base.current_project_proc
      end
      
      def current_project_id
        current_project && current_project.id
      end
    end
    
    def current_project
      self.class.current_project
    end
    
    def current_project_id
      self.class.current_project_id
    end
  end
end

ActionController::Base.class_eval {include CurrentProjectHelper}
ActiveRecord::Base.class_eval {extend CurrentProjectHelper::ActiveRecordHelpers::ClassMethods}
ActiveRecord::Base.class_eval {include CurrentProjectHelper::ActiveRecordHelpers}