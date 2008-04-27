require File.dirname(__FILE__) + '/../spec_helper'

describe Gender do
  it "should require locus" do
    @gender = Gender.new
    @gender.should have(1).error_on(:locus)
  end
end
