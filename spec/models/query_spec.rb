require File.dirname(__FILE__) + '/../spec_helper'

require "query.rb"

describe Query do
  fixtures :users, :projects, :organisms, :microsatellites, :queries, :dna_results, :samples
  
  before(:each) do
    ActiveRecord::Base.current_project_proc = lambda{projects(:whale_project)}
    @query = Query.new(:name => "My Query")
  end

  describe "when building includes" do
    it "should build properly" do
      assert @query.add_include("", "samples")
      assert @query.add_include("samples", "dna_results")
      {:project => {:samples => { :dna_results => {}}}}.should == @query.data[:includes].to_hash
    end
    
    it "should only allow sorting for columns in the select field (since some columns may be computed via crosstab)" do
      @query.add_include("samples")
      @query.add_include("samples/dna_results")
      
    end
    
    it "should should not allow duplicate includes on the same or a different level" do
      assert @query.add_include("/", "samples")
      assert @query.add_include("/samples", "dna_results")
      assert @query.add_include("/", "organisms")

      assert ! @query.add_include("/organisms", "samples")
      assert ! @query.add_include("/samples", "dna_results")
      assert ! @query.add_include("/samples/dna_results", "project")
      {:project => {:samples => {:dna_results => {}}, :organisms => {} } }.should == @query.data[:includes].to_hash
    end

    it "should shouldnt allow recursion" do
      assert @query.add_include("/", "samples")
      assert @query.add_include("/samples", "dna_results")
      assert ! @query.add_include("/samples/dna_results", "sample")

      {:project => {:samples => {:dna_results => {}}}}.should == @query.data[:includes].to_hash
    end
  end
  
  describe "simple case" do
    before(:each) do
      @query.add_include("samples/dna_results")
      @query.add_include("organisms")
      @query.add_fields(
        :samples => %w[organism_code tubebc], 
        :organisms => %w[comment], 
        :dna_results => %w[extraction_methods]
      )
      @query.add_sort("samples_organism_code", :desc)
      @query.add_sort("samples_plateposition", :asc)
    end
    
    it "should add fields should add" do
      @query.fields.should have(4).items
      @query.fields.map{|f| f.name.to_s}.sort.should == %w[comment extraction_methods organism_code tubebc]
    end

    # Replace this with your real test s.
    it "should build sql should build executable sql" do
      puts @query.to_sql
    end
    
    it "should return sort fields"
    
    it "should return a list of all fields selected from"
    
    
  end
end