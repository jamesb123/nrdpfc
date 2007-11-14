require File.dirname(__FILE__) + '/../../test_helper'

class MicrosatelliteOrganismCompilerTest < Test::Unit::TestCase
  fixtures :projects, :microsatellites, :samples, :organisms
  def setup
    @project =  projects(:whale_project)
    @project_id = @project.id
    
    @compiler = MicrosatelliteOrganismCompiler.new(@project_id)
    @table_name = "microsatellite_organism_horizontals_#{@project_id}"
#    dbg
    @model = MicrosatelliteOrganismHorizontal.model_for_project(@project)
  end
  
  def test__create_table_for_project__should_create
    @compiler.create_table
    
    tables = Project.connection.select_values("show tables")
    assert tables.include?(@table_name)
    
    fields = Project.connection.select_all("show columns from #{@table_name}").map{|h| h["Field"]}
    
    @project.microsatellites.each{|m|
      assert fields.include?("#{m.locus}a")
      assert fields.include?("#{m.locus}b")
    }
  end
  
  def test__compile_data
    @compiler.compile
    @results = @model.find(:all)
    y @results
    
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
 