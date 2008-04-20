require "#{File.dirname(__FILE__)}/../test_helper"

class DefaultProjectTest < ActionController::IntegrationTest
  fixtures :users, :security_settings, :projects, :microsatellites
  
  def regular_user
    open_session do | user |
      def user.logs_in_as(login, password)
        post "/account/login", :login => login, :password => password
      end
      
      def user.logs_in_as!(login, password)
        logs_in_as(login, password)
        is_logged_in_as login
      end
      
      def user.is_logged_in_as(login)
        u = User.find_by_id(session[:user])
        assert u, "Noone is logged in!"
        assert_equal u.login, login, "Should've been logged in as #{login}, but instead was #{u.login}"
      end
      
      def user.clicks_microsatellites_tab(params = {})
        get "/microsatellites", params
        assert_response :success
      end
      
      def user.current_project
        Project.find_by_id(session[:project_id])
      end
    end
  end
  
  def test__no_project_access__should_not_throw_error
    SecuritySetting.delete_all
    Project.update_all("user_id=null")
    
    quentin = regular_user_logged_in_as_quentin
    quentin.clicks_microsatellites_tab
    
  end
  
  def test__should_auto_select_first_available_project
    quentin = regular_user_logged_in_as_quentin
    quentin.clicks_microsatellites_tab
    assert_equal(projects(:whale_project).id, quentin.current_project_id)
  end
protected
  def regular_user_logged_in_as_quentin
    quentin = regular_user
    quentin.logs_in_as!("quentin", "test")
    quentin
  end
end
