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
        :dna_results => %w[extraction_method]
      )
      @query.add_sort("sample_organism_code", :desc)
      @query.add_sort("organism_comment", :asc)
    end
    
    it "should add fields should add" do
      @query.fields.should have(4).items
      @query.fields.map{|f| f.name.to_s}.sort.should == %w[comment extraction_method organism_code tubebc]
    end

    it "should build sql should build executable sql" do
      results = Project.connection.select_all(@query.to_sql)
      results.length.should == 2
      results[0].keys.sort.should == %w[dna_result_extraction_method organism_comment sample_organism_code sample_tubebc]
    end    
    
    it "should include sort fields in query" do
      @query.to_sql.should include("ORDER BY sample_organism_code desc, organism_comment asc")
    end
    
    it "should return a list of all fields selected from" do
      @query.to_sql.grep(/SELECT/).should == ["SELECT `dna_results`.`extraction_method` as `dna_result_extraction_method`, `samples`.`organism_code` as `sample_organism_code`, `samples`.`tubebc` as `sample_tubebc`, `organisms`.`comment` as `organism_comment`\n"]
    end
  end
  
  describe "when querying over a dynamic table name model and a model with dynamic attributes" do
    before(:each) do
      @query.add_include("organisms")
      @query.add_include("samples/microsatellite_horizontals")
      @query.add_fields(
        :organisms => %w[comment], 
        :dna_results => %w[extraction_method]
      )
      @query.add_sort("sample_organism_code", :desc)
      @query.add_sort("organism_comment", :asc)
    end
    
    it "should add fields should add" do
      @query.fields.should have(4).items
      @query.fields.map{|f| f.name.to_s}.sort.should == %w[comment extraction_method organism_code tubebc]
    end

    it "should build sql should build executable sql" do
      results = Project.connection.select_all(@query.to_sql)
      results.length.should == 2
      results[0].keys.sort.should == %w[dna_result_extraction_method organism_comment sample_organism_code sample_tubebc]
    end    
    
    it "should include sort fields in query" do
      @query.to_sql.should include("ORDER BY sample_organism_code desc, organism_comment asc")
    end
    
    it "should return a list of all fields selected from" do
      @query.to_sql.grep(/SELECT/).should == ["SELECT `dna_results`.`extraction_method` as `dna_result_extraction_method`, `samples`.`organism_code` as `sample_organism_code`, `samples`.`tubebc` as `sample_tubebc`, `organisms`.`comment` as `organism_comment`\n"]
    end
  end
end
