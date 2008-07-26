require File.dirname(__FILE__) + '/../../spec_helper'

describe String do
  describe "titleize_with_id" do
    it "should convert 'id' to 'Id'" do
      "id".titleize_with_id.should       == "Id"
    end
    it "should convert 'thing_id' to 'Thing Id'" do
      "thing_id".titleize_with_id.should == "Thing Id"
    end
  end
end
