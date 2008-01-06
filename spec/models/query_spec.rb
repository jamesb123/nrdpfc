require File.dirname(__FILE__) + '/../spec_helper'

require "query.rb"

describe Query do
  fixtures :users, :projects, :organisms, :microsatellites, :queries, :dna_results, :samples
  
  before(:each) do
    ActiveRecord::Base.current_project_proc = lambda{projects(:whale_project)}
    @query = Query.new(:name => "My Query")
  end


  it "should build_includes__should_build" do
    
    assert @query.add_include("", "samples")
    assert @query.add_include("samples", "dna_results")
    assert_equal({:project => {:samples => { :dna_results => {}}}}, @query.data[:includes].to_hash)
  end
  
  it "should build_includes__should_not_allow_duplicates_on_same_or_diff_level" do
    assert @query.add_include("/", "samples")
    assert @query.add_include("/samples", "dna_results")
    assert @query.add_include("/", "organisms")
    
    assert ! @query.add_include("/organisms", "samples")
    assert ! @query.add_include("/samples", "dna_results")
    assert ! @query.add_include("/samples/dna_results", "project")
    assert_equal({:project => {:samples => {:dna_results => {}}, :organisms => {} } }, @query.data[:includes].to_hash)
  end
  
  it "should build_includes__shouldnt_allow_recursion" do
    assert @query.add_include("/", "samples")
    assert @query.add_include("/samples", "dna_results")
    assert ! @query.add_include("/samples/dna_results", "sample")
    
    assert_equal({:project => {:samples => {:dna_results => {}}}}, @query.data[:includes].to_hash)
  end
  
  it "should add_fields__should_add" do
    setup_simple_case
    assert_equal(4, @query.fields.length)
    assert_equal(
      %w[comment extraction_methods organism_code tubebc], 
      @query.fields.map{|f| f.name.to_s}.sort
    )
  end
  
  # Replace this with your real tests.
  it "should build_sql__should_build_executable_sql" do
    setup_simple_case
    puts @query.to_sql
  end
  
  def setup_simple_case
    @query.add_include("samples/dna_results")
    @query.add_include("organisms")
    @query.add_fields(
      :samples => %w[organism_code tubebc], 
      :organisms => %w[comment], 
      :dna_results => %w[extraction_methods]
    )
    
  end
end