require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  fixtures :users, :projects, :organisms, :microsatellites, :queries, :dna_results, :samples
  
  before(:each) do
    @user = create_user
  end
  
  it "should create a default user" do
    @user.should be_valid
  end
  
  it "should allow multiple admin users" do
    create_user(:is_admin => true, :login => 'other_1', :email => 'other_1@example.com')
    lambda{ create_user(:is_admin => true, :login => 'other_2', :email => 'other_2@example.com') }.should_not raise_error
  end

  protected
    def create_user(options = {})
      record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
      # record.register! if record.valid?
      record.save!
      record
    end
end
