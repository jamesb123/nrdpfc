require File.dirname(__FILE__) + '/../test_helper'
require 'dynamic_attributes_controller'

# Re-raise errors caught by the controller.
class DynamicAttributesController; def rescue_action(e) raise e end; end

class DynamicAttributesControllerTest < Test::Unit::TestCase
  def setup
    @controller = DynamicAttributesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
