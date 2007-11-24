require File.dirname(__FILE__) + '/../test_helper'

class GenderFinalHorizontalTest < ActiveSupport::TestCase
  def test_authorize_all_for_crud
    @gender = Gender.new
    
    %w[create read update destroy].each{|crud|
      assert(@gender.send("authorized_for_#{crud}?"))
    }
  end
end
