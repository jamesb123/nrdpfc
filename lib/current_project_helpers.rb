# This was changed from the active_scaffold pattern of using class attributes
# due to threading concerns: http://m.onkey.org/2008/10/23/thread-safety-for-your-rails
  
module CurrentProjectHelper
  def self.included(base)
    base.helper_method :current_project=, :current_project, :current_project_id

    base.prepend_before_filter :current_project_required

    ActiveRecord::Base.class_eval {extend CurrentProjectHelper::ActiveRecordHelpers::ClassMethods}
    ActiveRecord::Base.class_eval {include CurrentProjectHelper::ActiveRecordHelpers}
  end
  
  def current_project=(project)
    project = project.is_a?(Project) ? project : Project.find(project)
    
    session[:project_id] = project.id unless project.nil?
    Thread.current[:current_project] = project
  end
  
  def current_project
    if Thread.current[:current_project].nil?
      project = if session[:project_id]
        Project.find(session[:project_id])
      else
        current_user.initial_project
      end

      self.current_project = project
    end

    return Thread.current[:current_project]
  end

  def current_project_required
    redirect_to :controller => :account, :action => :unassigned_user if current_project.nil?
  end
  
  def current_project_id
    current_project && current_project.id
  end
  
  module ActiveRecordHelpers
    module ClassMethods
      def current_project
        Thread.current[:current_project]
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
