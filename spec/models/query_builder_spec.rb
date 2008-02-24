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
      {:projects => {:samples => { :dna_results => {}}}}.should == @query_builder.includes.to_hash
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
      {:projects => {:samples => {:dna_results => {}}, :organisms => {} } }.should == @query_builder.includes.to_hash
    end

    it "should shouldnt allow recursion" do
      assert @query_builder.add_include("/", "samples")
      assert @query_builder.add_include("/samples", "dna_results")
      assert ! @query_builder.add_include("/samples/dna_results", "sample")

      {:projects => {:samples => {:dna_results => {}}}}.should == @query_builder.includes.to_hash
    end
  end
  
  describe "when auto-building includes" do
    it "should automatically figure out how to include tables" do
      @query_builder.add_tables "organisms", "microsatellite_horizontals"
      @query_builder.includes.to_hash.should == {
          :projects => {
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
      @query_builder.add_order("samples_organism_code", :desc)
      @query_builder.add_order("organisms_nea", :asc)
    end
    
    it "should add fields should add" do
      @query_builder.fields.should have(4).items
      @query_builder.fields.map{|f| f.name.to_s}.sort.should == ["extraction_method", "nea", "organism_code", "tubebc"]
    end

    it "should build sql should build executable sql" do
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 2
      results[0].keys.sort.should == %w[dna_results_extraction_method organisms_nea samples_organism_code samples_tubebc]
    end    
    
    it "should include sort fields in query" do
      @query_builder.to_sql.should include("ORDER BY samples_organism_code desc, organisms_nea asc")
    end
    
    it "should return a list of all fields selected from" do
      @query_builder.to_sql.grep(/SELECT/).should == ["SELECT `dna_results`.`extraction_method` as `dna_results_extraction_method`, `organism_dynamic_attribute_nea`.`integer_value` as organisms_nea, `samples`.`organism_code` as `samples_organism_code`, `samples`.`tubebc` as `samples_tubebc`\n"]
    end
    
    it "should return a list of select_field_aliases" do
      @query_builder.select_field_aliases.should == ["dna_results_extraction_method", "organisms_nea", "samples_organism_code", "samples_tubebc"]
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
      results.first.should == {"microsatellite_horizontals_EV1Pma"=>"137", "microsatellite_horizontals_EV1Pmb"=>"137"}
    end
    
    it "should filter on one column" do
      @query_builder.add_filter("microsatellite_horizontals", "EV1Pma", "=", "137")
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 1
      results.first.should == {"microsatellite_horizontals_EV1Pma"=>"137", "microsatellite_horizontals_EV1Pmb"=>"137"}
    end

    it "should filter via and" do
      @query_builder.add_filter("microsatellite_horizontals", "EV1Pma", "=", "137")
      @query_builder.add_filter("microsatellite_horizontals", "EV1Pma", "=", "138")
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 0
    end
    
    it "should filter via and with symbols" do
      @query_builder.add_filter(:microsatellite_horizontals, :EV1Pma, "=", "137")
      @query_builder.add_filter(:microsatellite_horizontals, :EV1Pma, "=", "138")
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 0
    end
    
    it "should ignore filters with not operator" do
      @query_builder.add_filter("microsatellite_horizontals", "EV1Pma", "", "137")
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 2
      
    end
    
    it "should prevent sql injection attacks"
  end
  
  # describe "when initializing from a query builder" do
  #   before(:each) do
  #     @query = Query.new(
  #       :tables => %w[microsatellite_horizontals organisms],
  #       :fields => {
  #         :microsatellite_horizontals => %w[EV1Pma EV1Pmb]
  #       }
  #     )
  #     @query_builder = QueryBuilder.new(@query.data)
  #   end
  #   
  #   it "should initialize form Query#data" do
  #     @query_builder.should_not be_nil
  #   end
  #   
  #   it "should receive table parameters" do
  #     @query_builder.tables.keys.map(&:to_s).sort.should == %w[microsatellite_horizontals organisms projects]
  #   end
  #   
  #   it "should receive field parameters" do
  #     @query_builder.fields.length == 2
  #     @query_builder.fields.first.name.should == :EV1Pma
  #   end
  # end
  # 
  it "should query project" do
    @query_builder = QueryBuilder.new
    @query_builder.add_tables("projects")
    @query_builder.add_fields(:projects => %w[name])
    @query_builder.fields.first.name.should == :name
    @query_builder.to_sql
  end
  
  it "should allow setting of a limit" do
    @query_builder = QueryBuilder.new
    @query_builder.add_tables("projects")
    @query_builder.limit = 10
    @query_builder.to_sql.should include("LIMIT 10")
  end
end
