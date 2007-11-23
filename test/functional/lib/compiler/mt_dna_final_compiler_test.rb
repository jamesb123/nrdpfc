require File.dirname(__FILE__) + '/../../../test_helper'

class Compiler::MtDnaFinalCompilerTest < Test::Unit::TestCase
  fixtures :projects, :mt_dnas, :samples, :organisms
  def setup
    @project =  projects(:whale_project)
    @project_id = @project.id
    
    @compiler = Compiler::MtDnaFinalCompiler.new(@project_id)
    @compiler.create_table
    @table_name = "mt_dna_final_horizontals_#{@project_id}"
    @model = MtDnaFinalHorizontal.model_for_project(@project)
  end
  
  def test__create_table_for_project__should_create
    @compiler.create_table
    
    tables = Project.connection.select_values("show tables")
    assert tables.include?(@table_name)
    
    fields = Project.connection.select_all("show columns from #{@table_name}").map{|h| h["Field"]}
    
    @project.mt_dnas.each{|m|
      assert fields.include?("#{m.locus}")
    }
  end
  
  def test__compile_data
    @compiler.compile
    @results = @model.find(:all)
    
    @results.each{|result|
      ["Control Region", "Cyt-b"].each{|col_name|
        assert_not_nil(result[col_name], "Expected data for #{col_name} - organism - #{result.organism.organism_code}")
      }
      assert_not_nil(result.project_id)
      assert_not_nil(result.organism_id)
      assert_not_nil(result.organism_code)
    }
    assert_equal(1, @results.length)
    
  end
end
 