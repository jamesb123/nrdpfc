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

    it "should should not allow duplicate includes on the same or a different level" do
      assert @query.add_include("/", "samples")
      assert @query.add_include("/samples", "dna_results")
      assert @query.add_include("/", "organisms")

      assert ! @query.add_include("/organisms", "samples")
      assert ! @query.add_include("/samples", "dna_results")
      assert ! @query.add_include("/samples/dna_results", "project")
      {:project => {:samples => {:dna_results => {}}, :organisms => {} } }.should == @query.data[:includes].to_hash
    end

    it "should shouldnt_allow_recursion" do
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
    end
    
    it "should add_fields__should_add" do
      @query.fields.should have(4).items
      @query.fields.map{|f| f.name.to_s}.sort.should ==         %w[comment extraction_methods organism_code tubebc]
    end

    # Replace this with your real tests.
    it "should build_sql__should_build_executable_sql" do
      puts @query.to_sql
    end
  end
end