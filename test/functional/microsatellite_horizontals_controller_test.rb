require File.dirname(__FILE__) + '/../test_helper'
require 'microsatellite_horizontals_controller'

# Re-raise errors caught by the controller.
class MicrosatelliteHorizontalsController; def rescue_action(e) raise e end; end

class MicrosatelliteHorizontalsControllerTest < Test::Unit::TestCase
  fixtures :microsatellites, :projects, :users
  def setup
    @controller = MicrosatelliteHorizontalsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test__nil_current_project__should_show_nothing
    assert false, "implement me"
  end
  # Replace this with your real tests.
#  def test__navigate_to_non_exiting_project__should_redirect
#    login_as :quentin
#    
#    get :list, :project_id => -1
#    puts @response.body
#    assert_response :redirect
#    
#  end
end
