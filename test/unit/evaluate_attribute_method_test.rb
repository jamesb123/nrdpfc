require File.dirname(__FILE__) + '/../test_helper'

class EvaluateAttributeMethodTest < Test::Unit::TestCase
  def test_should_sanitize
    method_name = "This method-stinks"
#    dbg
    MicrosatelliteFinalHorizontal.send(:evaluate_attribute_method, method_name, "def #{method_name}; true; end;")
    assert MicrosatelliteFinalHorizontal.new.respond_to?("This_method_stinks")
  end
end