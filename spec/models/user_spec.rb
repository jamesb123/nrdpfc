require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  #fixtures :users, :projects, :organisms, :microsatellites, :queries, :dna_results, :samples
  
  before(:each) do
    #@project = projects(:whale_project)
    #ActiveRecord::Base.current_project_proc = lambda { @project }
    #@query_builder = QueryBuilder.new
    @user = create_user
  end
  
  it "should create a default user" do
    @user.should be_valid
  end
  
  it "should be assigned to the manager-less project by default" do
    @user.current_project.name.should eql('Default')
  end

  protected
    def create_user(options = {})
      record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
      # record.register! if record.valid?
      record.save!
      record
    end
end
