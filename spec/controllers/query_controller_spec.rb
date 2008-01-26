require File.dirname(__FILE__) + '/../spec_helper'

describe QueryController do
  include AuthenticatedTestHelper
  fixtures :users, :security_settings, :projects, :dna_results, :samples, :mhc_seqs, :organisms
  
  integrate_views
  
  describe "when posting to show" do
    before(:each) do
      login_as :quentin
      post :show, :query => { 
        :tables => %w[dna_results organisms],
        :fields => {
          'organisms' => ['comment', 'organism_code'],
          'dna_results' => ['barcode'],
        }
      }
      @query = assigns[:query]
      @query_builder = assigns[:query_builder]
      @results = assigns[:results]
    end
      
    it "should create a query from parameters" do
      @query.tables.should == %w[dna_results organisms]
      @query.fields.should == { 'organisms' => %w[comment organism_code], 'dna_results' => ['barcode']}
    end
    
    it "should create a QueryBuilder from that query" do
      @query_builder.should_not be_nil
      @query_builder.tables.keys.map(&:to_s).sort.should == %w[dna_results organisms project samples]
      @query_builder.fields.map(&:name).should == [:barcode, :comment, :organism_code]
    end
    
    it "should execute the query and return it in results" do
      @results.class.should == Array
    end
  end
  
end