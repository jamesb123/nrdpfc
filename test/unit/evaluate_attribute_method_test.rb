require File.dirname(__FILE__) + '/../test_helper'

class EvaluateAttributeMethodTest < Test::Unit::TestCase
  def setup
    @model = Class.new(MicrosatelliteFinalHorizontal)
  end
    
  def test_should_sanitize
    define_method("This method-stinks")
    assert_responds_to("This_method_stinks")
  end
  
  def test_should_handle_symbols
    define_method(:hello)
    assert_responds_to("hello")
  end
protected
  def define_method(method_name)
    @model.send(:evaluate_attribute_method, method_name, "def #{method_name}; true; end;")
  end
  
  def assert_responds_to(method_name)
    assert @model.new.respond_to?(method_name)
    
  end
end