require File.dirname(__FILE__) + '/../test_helper'
require 'security_settings_controller'

# Re-raise errors caught by the controller.
class SecuritySettingsController; def rescue_action(e) raise e end; end

class SecuritySettingsControllerTest < Test::Unit::TestCase
#  fixtures :security_settings, :users
#
#  def setup
#    @controller = SecuritySettingsController.new
#    @request    = ActionController::TestRequest.new
#    @response   = ActionController::TestResponse.new
#    
#    login_as :quentin
#  end
#
#  def test_should_get_index
#    get :index
#    assert_response :success
#    assert assigns(:security_settings)
#  end
#
#  def test_should_get_new
#    get :new
#    assert_response :success
#  end
#  
#  def test_should_create_security_setting
#    old_count = SecuritySetting.count
#    post :create, :security_setting => { }
#    assert_equal old_count+1, SecuritySetting.count
#    
#    assert_redirected_to security_setting_path(assigns(:security_setting))
#  end
#
#  def test_should_show_security_setting
#    get :show, :id => 1
#    assert_response :success
#  end
#
#  def test_should_get_edit
#    get :edit, :id => 1
#    assert_response :success
#  end
#  
#  def test_should_update_security_setting
#    put :update, :id => 1, :security_setting => { }
#    assert_redirected_to security_setting_path(assigns(:security_setting))
#  end
#  
#  def test_should_destroy_security_setting
#    old_count = SecuritySetting.count
#    delete :destroy, :id => 
#    assert_equal old_count-1, SecuritySetting.count
#    
#    assert_redirected_to security_settings_path
#  end
end
