class AccountController < ApplicationController
  layout "master"

  # If you want "remember me" functionality, add this before_filter to Application Controller
  #  before_filter :login_from_cookie

  skip_before_filter :login_required, :except => :register_to_project
  skip_before_filter :set_current_project
  
  def authorized?
    current_user ? true : false
  end
    
  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
  end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    self.current_project = params[:project_id] unless params[:project_id].blank?
    
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      
      flash[:notice] = "Logged in successfully"

      # Send the user to an explanation page 
      # if they're in limbo, waiting to be 
      # assigned to a project.
      if !current_user.has_access_to_active_projects?
          if current_user.is_project_manager?
            self.current_project = self.current_user.project_id
            redirect_back_or_default(:controller => '/projects')
          else
            redirect_to(:action => 'unassigned_user')
          end
      else
        self.current_project = self.current_user.project_id
        redirect_back_or_default(:controller => '/projects')
      end
      
    else
      flash[:notice] = "Incorrect login, please try again."
    end
  
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/account', :action => 'index')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/account', :action => 'login')
  end
end
