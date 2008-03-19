require File.dirname(__FILE__) + '/../spec_helper'

describe Project do

  it "should create a project" do
    @project = create_project
    @project.should be_valid
  end
  
  it "should raise an error if there is no user_id and there is no current_user" do
    lambda{@project = create_project(:user_id => nil)}.should raise_error
  end

  it "should not try and assign a project owner for a project named Default" do
    @project = create_project(:name => 'Default', :user_id => nil)
    @project.user_id.should be_nil
  end
  
  protected
    def create_project(options = {})
      record = Project.new({:user_id => 1 }.merge(options))
      record.save!
      record
    end
end
