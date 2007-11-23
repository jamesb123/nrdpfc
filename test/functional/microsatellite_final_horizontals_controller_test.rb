require File.dirname(__FILE__) + '/../test_helper'
require 'microsatellite_final_horizontals_controller'

# Re-raise errors caught by the controller.
class MicrosatelliteFinalHorizontalsController; def rescue_action(e) raise e end; end

class MicrosatelliteFinalHorizontalsControllerTest < Test::Unit::TestCase
  def setup
    @controller = MicrosatelliteFinalHorizontalsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
