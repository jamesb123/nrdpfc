require File.dirname(__FILE__) + '/../test_helper'

class ProjectsControllerTest < ActionController::TestCase
  fixtures :users, :projects, :security_settings
  tests ProjectsController

  # Replace this with your real tests.
  def test_update_current_project__should_reflect_in_active_record
    assert_nil(User.current_project)
    
    login_as :quentin
    
    get :update_current_project, :current_project_id => projects(:whale_project)
    
    assert_equal projects(:whale_project).to_label, User.current_project.to_label
    
  end
end
