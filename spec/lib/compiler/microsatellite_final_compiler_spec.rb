require File.dirname(__FILE__) + '/../../spec_helper'

class Compiler::MicrosatelliteFinalCompilerTest < Test::Unit::TestCase
  fixtures :projects, :microsatellites, :samples, :organisms
  def setup
    @project =  projects(:whale_project)
    @project_id = @project.id
    
    @compiler = Compiler::MicrosatelliteFinalCompiler.new(@project_id)
    @compiler.create_table
    @table_name = "microsatellite_final_horizontals_#{@project_id}"
    @model = MicrosatelliteFinalHorizontal.model_for_project(@project)
  end
  
  it "should create_table_for_project__should_create" do
    @compiler.create_table
    
    tables = Project.connection.select_values("show tables")
    assert tables.include?(@table_name)
    
    fields = Project.connection.select_all("show columns from #{@table_name}").map{|h| h["Field"]}
    
    @project.microsatellites.each{|m|
      assert fields.include?("#{m.locus}a")
      assert fields.include?("#{m.locus}b")
    }
  end
  
  it "should compile_data" do
    @compiler.compile
    @results = @model.find(:all)
#    y @results
    
    @results.each{|result|
      %w[EV1Pma EV1Pmb EV37Mna EV37Mnb].each{|col_name|
        assert_not_nil(result[col_name], "Expected data for #{col_name} - organism - #{result.organism.organism_code}")
      }
      assert_not_nil(result.project_id)
      assert_not_nil(result.organism_id)
      assert_not_nil(result.organism_code)
    }
    assert_equal(1, @results.length)
    
  end
end
 