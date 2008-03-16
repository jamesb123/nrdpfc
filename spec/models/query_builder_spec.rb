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
      assert @query_builder.add_include("samples", "dna_results")
      {:samples => { :dna_results => {}}}.should == @query_builder.includes.to_hash
    end
    
    it "should only allow sorting for columns in the select field (since some columns may be computed via crosstab)" do
      @query_builder.add_include("samples")
      @query_builder.add_include("samples/dna_results")
      
    end
    
    it "should should not allow duplicate includes on the same or a different level" do
      assert @query_builder.add_include("/", "dna_results")
      assert @query_builder.add_include("/", "organism")

      assert ! @query_builder.add_include("/organisms", "samples")
      assert ! @query_builder.add_include("/samples", "dna_results")
      @query_builder.includes.to_hash.should == {:samples => {:dna_results => {}, :organism => {}} }
    end

    it "should shouldnt allow recursion" do
      assert @query_builder.add_include("/samples", "dna_results")
      assert ! @query_builder.add_include("/samples/dna_results", "sample")

      @query_builder.includes.to_hash.should == {:samples => {:dna_results => {}}}
    end
  end
  
  describe "when auto-building includes" do
    it "should automatically figure out how to include tables" do
      @query_builder.add_tables "organisms", "microsatellite_horizontals"
      @query_builder.includes.to_hash.should == {:samples=>{:organism=>{}, :microsatellite_horizontals=>{}}}
    end
  end
  
  describe "case when it should link together" do
    before(:each) do
      @query_builder.add_tables "samples", "organisms"
      @query_builder.tables[:organisms].should_not be_nil
      @query_builder.add_fields(
        :samples => ["organism_code"],
        :organisms => ["organism_code"]
      )
    end
    
    it "should description" do
      @query_builder.includes.joins.join.should == ["LEFT JOIN organisms ON (organisms.id = samples.organism_id)"]
    end
  end
  describe "simple case" do
    
    before(:each) do
      @query_builder.add_tables "samples", "organisms", "dna_results"
      
      # @query_builder.add_include("samples/dna_results")
      # @query_builder.add_include("organisms")
      @query_builder.add_fields(
        :samples => %w[tubebc receiver_comments], 
        :organisms => %w[nea organism_code], 
        :dna_results => %w[extraction_method]
      )
      @query_builder.add_order("organisms_organism_code", :desc)
      @query_builder.add_order("organisms_nea", :asc)
    end
    
    it "should add fields should add" do
      @query_builder.fields.should have(5).items
      @query_builder.fields.map{|f| f.name.to_s}.sort.should == ["extraction_method", "nea", "organism_code", "receiver_comments", "tubebc"]
    end

    it "should build sql should build executable sql" do
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 2
      results[0].keys.sort.should == ["dna_results_extraction_method", "organisms_nea", "organisms_organism_code", "samples_receiver_comments", "samples_tubebc"]
      results.map{|r| r["samples_receiver_comments"]}.should == ["Fin sample", "Nose sample"]
    end    
    
    it "should include sort fields in query" do
      @query_builder.to_sql.should include("ORDER BY organisms_organism_code desc, organisms_nea asc")
    end
    
    it "should return a list of all fields selected from" do
      @query_builder.to_sql.grep(/SELECT/).should == ["SELECT `dna_results`.`extraction_method` as `dna_results_extraction_method`, `organism_dynamic_attribute_nea`.`integer_value` as organisms_nea, `organisms`.`organism_code` as `organisms_organism_code`, `samples`.`tubebc` as `samples_tubebc`, `samples`.`receiver_comments` as `samples_receiver_comments`\n"]
    end
    
    it "should return a list of select_field_aliases" do
      @query_builder.select_field_aliases.should == ["dna_results_extraction_method", "organism_nea", "organism_organism_code", "samples_tubebc", "samples_receiver_comments"]
    end
  end
  
  describe "when querying over a model with dynamic attributes" do
    fixtures :dynamic_attribute_values
    before(:each) do
      @query_builder.add_tables "organisms"
      
      @query_builder.add_include("organisms")
      @query_builder.add_fields(
        :samples => %w[receiver_comments],
        :organisms => %w[notes nea]
      )
    end
    
    it "should build sql should build executable sql" do
      results = Project.connection.select_all(@query_builder.to_sql)
      results.length.should == 2
      results.first.should == {
        "organisms_nea"=>"15",
        "organisms_notes"=>"these are some far out notes",
        "samples_receiver_comments"=>"Fin sample"}
      
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
  it "should query sample" do
    @query_builder = QueryBuilder.new
    @query_builder.add_tables("samples")
    @query_builder.add_fields(:samples => %w[organism_code])
    @query_builder.fields.first.name.should == :organism_code
    @query_builder.to_sql
  end
  
  it "should respect wildcards when adding fields" do
    @query_builder = QueryBuilder.new
    @query_builder.add_tables("genders")
    @query_builder.add_fields(:genders => ["*"])
    @query_builder.fields.map(&:name).should == [:id, :sample_id, :project_id, :gender, :gelNum, :wellNum, :finalResult, :locus]
    @query_builder.to_sql
  end
  
  it "should respect wildcards when adding fields" do
    @query_builder = QueryBuilder.new
    @query_builder.add_tables("projects")
    @query_builder.add_fields(:projects => ["*"])
    @query_builder.fields.map(&:name).should == [:id, :name, :code, :description, :user_id, :recompile_required]
    @query_builder.to_sql
  end
  
  it "should allow setting of a limit" do
    @query_builder = QueryBuilder.new
    @query_builder.add_tables("samples")
    @query_builder.limit = 10
    @query_builder.to_sql.should include("LIMIT 10")
  end
end
