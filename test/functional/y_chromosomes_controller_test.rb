require File.dirname(__FILE__) + '/../test_helper'
require 'y_chromosomes_controller'

# Re-raise errors caught by the controller.
class YChromosomesController; def rescue_action(e) raise e end; end

class YChromosomesControllerTest < Test::Unit::TestCase
  fixtures :y_chromosomes
  
  def test_truth
    assert true
  end
  
end
