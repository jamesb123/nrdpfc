require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  include AuthenticatedTestHelper
  fixtures :users, :security_settings, :projects
  #, :dna_results, :samples, :mhc_seqs, :organisms
  
  before(:each) do
    current_project = projects(:whale_project)
  end
  
  describe "when getting index" do
    integrate_views
    
    it "should get with a valid admin user" do
      login_as :admin
      get :index
      response.should be_success
    end
  end
  
end