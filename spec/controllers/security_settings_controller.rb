require File.dirname(__FILE__) + '/../spec_helper'

describe SecuritySettingsController do
  include AuthenticatedTestHelper
  fixtures :users
  
  describe "when getting index" do
    
    it "should get with a valid admin user" do
      login_as :admin
      get :index
      response.should be_success
    end
    
    it "should return all people for an admin user" do
      Factory.create(:fixture_security_setting)
      login_as :admin
      get :index
      assigns[:records].size.should eql(2)
    end
#    it "should get with a project manager"
#    it "should return only a projecty manager's people"
  end
  
end
