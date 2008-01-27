require File.dirname(__FILE__) + '/../spec_helper'

describe QueryController do
  include AuthenticatedTestHelper
  fixtures :users, :security_settings, :projects, :dna_results, :samples, :mhc_seqs, :organisms
  
  before(:each) do
    login_as :quentin
  end
  
  describe "when getting index" do
    integrate_views
    
    it "should get" do
      get :index
    end
  end
  describe "when posting to show" do
    integrate_views
    before(:each) do
      post :show, :query => { :data => { 
        :dna_results => {
          :barcode => { :select => "true" }
        },
        :organisms => {
          :comment =>       { :select => "true" },
          :organism_code => { :select => "true" }
        }
      }}
      @query = assigns[:query]
      @query_builder = assigns[:query_builder]
      @results = assigns[:results]
    end
      
    it "should create a query from parameters" do
      @query.data.keys.map(&:to_s).sort.should == %w[dna_results organisms]
      @query.data[:organisms].keys.map(&:to_s).sort.should == %w[comment organism_code]
      @query.data[:dna_results].keys.map(&:to_s).sort.should == %w[barcode]
    end
    
    it "should create a QueryBuilder from that query" do
      @query_builder.should_not be_nil
      query_tables_names = @query_builder.tables.keys
      
      [:dna_results, :organisms, :projects, :samples].each do |table|
        query_tables_names.should include(table)
      end
      
      query_field_names = @query_builder.fields.map(&:name)
      
      [:barcode, :comment, :organism_code].each do |field_name|
        query_field_names.should include(field_name)
      end
    end
    
    it "should execute the query and return it in results" do
      @results.class.should == Array
    end
    
  end
  
  describe "when adding a numeric field" do
    integrate_views
    include ERB::Util
    before(:each) do
      post :add_field, :model => "dna_results", :field => "pico_green_conc"
    end
    
    it "should add a field with numeric fiters" do
      response.should have_tag("select[name=?]", "query[dna_results][pico_green_conc][filter][operator]") do |r|
        ['<', '<=', 'not =', '=', '>', '>=', 'not in', 'in'].each do |operator|
          r.should have_tag("option[value=?]", h(operator))
        end
      end
    end
    
    it "should include a hidden element to the form" do
      response.should have_tag("input[type=hidden]")
      response.should have_tag("input[type=hidden][name=?][value=?]", "query[dna_results][pico_green_conc][select]", "true")
    end
  end
  
end