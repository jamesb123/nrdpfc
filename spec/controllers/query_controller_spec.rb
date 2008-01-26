require File.dirname(__FILE__) + '/../spec_helper'

describe QueryController do
  include AuthenticatedTestHelper
  fixtures :users, :security_settings, :projects, :dna_results
  
  describe "when posting to show" do
    before(:each) do
      login_as :quentin
      post :show, :query => { 
        :tables => %w[dna_results projects],
        :fields => {
          'projects' => ['name', 'code'],
          'dna_results' => ['locus'],
        }
      }
      @query = assigns[:query]
      @query_builder = assigns[:query_builder]
    end
      
    it "should create a query from parameters" do
      @query.tables.should == %w[dna_results projects]
      @query.fields.should == { 'projects' => %w[name code], 'dna_results' => ['locus']}
    end
    
    it "should create a QueryBuilder from that query" do
      @query_builder.should_not be_nil
    end
  end
  
end