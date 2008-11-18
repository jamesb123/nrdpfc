# This was changed from the active_scaffold pattern of using class attributes
# due to threading concerns: http://m.onkey.org/2008/10/23/thread-safety-for-your-rails
  
module CurrentProjectHelper
  def self.included(base)
    base.helper_method :current_project=, :current_project, :current_project_id

    base.prepend_before_filter :set_current_project

    ActiveRecord::Base.class_eval {extend CurrentProjectHelper::ActiveRecordHelpers::ClassMethods}
    ActiveRecord::Base.class_eval {include CurrentProjectHelper::ActiveRecordHelpers}
  end

  def set_current_project
    # This call makes sure that the value in Thread.current[:current_project] is
    # updated on each request. Otherwise it would retain the data from the previous request.
    # If current_project is nil, many errors will be thrown by accessing the main app
    if current_user && current_project.nil?
      redirect_to :controller => :account, :action => :unassigned_user 
    end
  end
  
  def current_project=(project)
    project = project.is_a?(Project) ? project : Project.find(project) rescue nil
  
    #Thread.current is assigned to give the models access to the current_project
    Thread.current[:current_project] = project

    session[:project_id] = project.nil? ? nil : project.id
    @current_project = project
  end
  
  def current_project
    # by checking @current_project, we keep Thread.current
    if @current_project.nil?
      # we can't call current_project to get the result of this assignment, so save it
      self.current_project = session[:project_id]

      # Many parts of the active_scaffold conditions depend on
      # the current_project, so we have to make sure it is
      # accessible to the current_user
      if current_user && (@current_project.nil? ||
                          !@current_project.readable_by?(current_user))
        self.current_project = current_user.initial_project 
      end
    end

    @current_project
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
