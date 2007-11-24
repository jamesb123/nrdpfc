require File.dirname(__FILE__) + '/../../../test_helper'

class Compiler::GenderFinalCompilerTest < Test::Unit::TestCase
  fixtures :projects, :genders, :samples, :organisms
  def setup
    @project =  projects(:whale_project)
    @project_id = @project.id
    
    @compiler = Compiler::GenderFinalCompiler.new(@project_id)
    @compiler.create_table
    @table_name = "gender_final_horizontals_#{@project_id}"
    @model = GenderFinalHorizontal.model_for_project(@project)
  end
  
  def test__create_table_for_project__should_create
    @compiler.create_table
    
    tables = Project.connection.select_values("show tables")
    assert tables.include?(@table_name)
    
    fields = Project.connection.select_all("show columns from #{@table_name}").map{|h| h["Field"]}
    
    @project.genders.each{|m|
      assert fields.include?("#{m.locus}")
    }
  end
  
  def test__blank_loci=__doesnt_error
    Gender.update_all("locus=''")
    @compiler.compile
  end
  
  def test__compile_data
    @compiler.compile
    @results = @model.find(:all)
    
    @results.each{|result|
      ["Control Region", "Cyt-b"].each{|col_name|
        assert_not_nil(result[col_name], "Expected data for #{col_name} - organism - #{result.organism.organism_code}")
        assert_equal("f", result[col_name], "Expected gender to be f for #{col_name}")
      }
      assert_not_nil(result.project_id)
      assert_not_nil(result.organism_id)
      assert_not_nil(result.organism_code)
      assert_equal("Egl00050", result.organism_code)
    }
    assert_equal(1, @results.length)
  end
  
  
end
 