require File.dirname(__FILE__) + '/../spec_helper'

require "query.rb"

describe Query do
  fixtures :users, :projects, :organisms, :microsatellites, :queries, :dna_results, :samples
  
  before(:each) do
    @query = Query.new :name => "My Query"
  end
  
  it "should default data to {}" do
    @query.data.should == {}
  end
  
  it "should default fields to a hash indexed with each table name" do
    @query.fields["organisms"].should == []
  end
  
end
