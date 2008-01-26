require File.dirname(__FILE__) + '/../spec_helper'

describe QueryBuilder do
  fixtures :users, :projects, :organisms, :microsatellites, :queries, :dna_results, :samples
  
  before(:each) do
    @project = projects(:whale_project)
    ActiveRecord::Base.current_project_proc = lambda { @project }
    @query_builder = QueryBuilder.new
  end

  describe "when building includes" do
    it "should build properly" do
      assert @query_builder.add_include("", "samples")
      assert @query_builder.add_include("samples", "dna_results")
      {:project => {:samples => { :dna_results => {}}}}.should == @query_builder.includes.to_hash
    end
    
    it "should only allow sorting for columns in the select field (since some columns may be computed via crosstab)" do
      @query_builder.add_include("samples")
      @query_builder.add_include("samples/dna_results")
      
    end
    
    it "should should not allow duplicate includes on the same or a different level" do
      assert @query_builder.add_include("/", "samples")
      assert @query_builder.add_include("/samples", "dna_results")
      assert @query_builder.add_include("/", "organisms")

      assert ! @query_builder.add_include("/organisms", "samples")
      assert ! @query_builder.add_include("/samples", "dna_results")
      assert ! @query_builder.add_include("/samples/dna_results", "project")
      {:project => {:samples => {:dna_results => {}}, :organisms => {} } }.should == @query_builder.includes.to_hash
    end

    it "should shouldnt allow recursion" do
      assert @query_builder.add_include("/", "samples")
      assert @query_builder.add_include("/samples", "dna_results")
      assert ! @query_builder.add_include("/samples/dna_results", "sample")

      {:project => {:samples => {:dna_results => {}}}}.should == @query_builder.includes.to_hash
    end
  end
  
  describe "when auto-building includes" do
    it "should automatically figure out how to include tables" do
      @query_builder.add_tables "organisms", "microsatellite_horizontals"
      @query_builder.includes.to_hash.should == {
          :project => {
            :organisms => {}, 
            :microsatellite_horizontals => {}
          }
        }
    end
  end
  
  describe "simple case" do
    
    before(:each) do
      @query_builder.add_tables "organisms", "dna_results"
      
      # @query_builder.add_include("samples/dna_results")
      # @query_builder.add_include("organisms")
      @query_builder.add_fields(
        :samples => %w[organism_code tubebc], 
        :organisms => %w[nea], 
        :dna_results => %w[extraction_method]
      )
      @query_builder.add_sort("sample_organism_code", :desc)
      @query_builder.add_sort("organisms_nea", :asc)
    end
    
    it "should add fields should add" do
      @query_builder.fields.should have(4).items
      @query_builder.fields.map{|f| f.name.to_s}.sort.should == ["extraction_method", "nea", "organism_code", "tubebc"]
    end

    it "should build sql should build executable sql" do
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 2
      results[0].keys.sort.should == %w[dna_result_extraction_method organisms_nea sample_organism_code sample_tubebc]
    end    
    
    it "should include sort fields in query" do
      @query_builder.to_sql.should include("ORDER BY sample_organism_code desc, organisms_nea asc")
    end
    
    it "should return a list of all fields selected from" do
      @query_builder.to_sql.grep(/SELECT/).should == ["SELECT `dna_results`.`extraction_method` as `dna_result_extraction_method`, `samples`.`organism_code` as `sample_organism_code`, `samples`.`tubebc` as `sample_tubebc`, `organism_dynamic_attribute_nea`.`integer_value` as organisms_nea\n"]
    end
  end
  
  describe "when querying over a model with dynamic attributes" do
    before(:each) do
      @query_builder.add_tables "organisms"
      
      @query_builder.add_include("organisms")
      @query_builder.add_fields(
        :organisms => %w[notes nea]
      )
    end
    
    it "should build sql should build executable sql" do
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 1
      results.first.should == {"organisms_nea"=>"15", "organisms_notes"=>"||- these are some far out notes"}
    end    
  end
  
  describe "when querying over a model with dynamic table attributes" do
    before(:each) do
      Compiler::MicrosatelliteCompiler.new(@project).compile
      
      @query_builder.add_include("microsatellite_horizontals")
      @query_builder.add_fields(
        :microsatellite_horizontals => %w[EV1Pma EV1Pmb]
      )
    end
    
    it "should build sql should build executable sql" do
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 2
      results.first.should == {"microsatellite_horizontal_EV1Pma"=>"137", "microsatellite_horizontal_EV1Pmb"=>"137"}
    end    
  end
end
