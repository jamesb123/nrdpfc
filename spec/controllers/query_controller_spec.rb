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
  
  describe "when posting to download" do
    before(:each) do
      post :download_csv, :data => { 
        :dna_results => {
          :barcode => { :select => "true" }
        },
        :organisms => {
          :comment =>       { :select => "true" },
          :organism_code => { :select => "true", :filters => {:operator => [">", "<"], :value => ["1", "1000"]} }
        }
      }
      
      @query = assigns[:query]
      @query_builder = assigns[:query_builder]
      @results = assigns[:results]
      @abs_filename = assigns[:abs_filename]
      
      @data = FasterCSV.parse(File.read(@abs_filename))
    end
      
    after(:each) do
      FileUtils.rm_f(@abs_filename)
    end
    
    it "should store the titles at the top" do
      @data[0].should == ["Dna Results Barcode", "Organisms Organism Code", "Organisms Comment"]
    end
  end
  
  describe "when posting to show" do
    
    integrate_views
    
    before(:each) do
      post :show, :data => { 
        :dna_results => {
          :barcode => { :select => "true" }
        },
        :organisms => {
          :comment =>       { :select => "true" },
          :organism_code => { :select => "true", :filters => {:operator => [">", "<"], :value => ["1", "1000"]} }
        }
      }
      
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
      
      [:samples, :organisms, :dna_results].each do |table|
        query_tables_names.should include(table)
      end
      
      query_field_names = @query_builder.fields.map(&:name)
      
      [:barcode, :comment, :organism_code].each do |field_name|
        query_field_names.should include(field_name)
      end
      
      @query_builder.filterings.should == [
        ["organisms", "organism_code", ">", "1"], 
        ["organisms", "organism_code", "<", "1000"]
      ]
    end
    
    it "should execute the query and return it in results" do
      @results.class.should == Array
    end
  end
  
  describe "when adding a numeric field" do
    integrate_views
    include ERB::Util
    before(:each) do
      post :add_field, :table => "dna_results", :field => "pico_green_conc"
    end
    
    it "should add a field with numeric filters" do
      post :add_filter, :table => "dna_results", :field => "pico_green_conc"
      
      response.should have_tag("select[name=?]", "data[dna_results][pico_green_conc][filters][operator][]") do |r|
        ['<', '<=', '<>', '=', '>', '>='].each do |operator|
          r.should have_tag("option[value=?]", h(operator))
        end
      end
    end
    
    it "should include a hidden element to the form" do
      response.should have_tag("input[type=hidden]")
      response.should have_tag("input[type=hidden][name=?][value=?]", "data[dna_results][pico_green_conc][select]", "true")
    end
  end
  
  describe "when adding all fields for a model" do
    integrate_views
    before(:each) do
      post :add_field, :table => "samples"
    end
      
    it "should add all non_id fields" do
      assigns[:query_fields].map(&:name).map(&:to_s).should == Sample.exportable_non_id_fields
    end
    
    it "should render all the fields at once" do
      Sample.exportable_non_id_fields.each do |field|
        response.body.should include(field.titleize)
      end
    end
  end
end