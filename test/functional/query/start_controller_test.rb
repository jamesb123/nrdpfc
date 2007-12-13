require File.dirname(__FILE__) + '/../../test_helper'

class Query::StartControllerTest < ActionController::TestCase
  fixtures :queries, :users, :security_settings, :projects
  tests Query::StartController
  
  def setup
    super
    login_as :aaron
    @request.session[:project_id] = projects(:whale_project)
  end
  
  # Replace this with your real tests.
  def test_get_index__no_queries__should_redirect_to_new
    Query.delete_all
    get :index
    assert_redirected_to({:action => "new"}, 'should redirect')
  end
  
  def test__get_new__should_get
    get :new
    assert_response :success
  end
  
  def test__create__should_create_and_set_current_project
    post :create, :query => {:name => "My Query"}
    assert_response :redirect
    
    query = assigns(:query)
    assert_equal("My Query", query.name)
    assert_equal(projects(:whale_project).to_label, query.project.to_label)
    assert query.draft
  end
end
