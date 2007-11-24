require File.dirname(__FILE__) + '/../test_helper'

class MicrosatelliteHorizontalTypeTest < Test::Unit::TestCase
  fixtures :microsatellites, :samples, :projects
  
  def setup
    @project = projects(:whale_project)
    
    @mc = Compiler::MicrosatelliteCompiler.new(@project.id)
    @mc.create_table
    
    @model = MicrosatelliteHorizontal.model_for_project(@project.id)
  end
  
  def test__model_for_project__existing_compiled_project__returns_model_with_all_columns
    # create the table
    column_names = @model.columns.map(&:name)
    %w[EV1Pma EV1Pmb EV37Mna EV37Mnb].each{|name|
      assert column_names.include?(name), "expected columns to include column #{name}, but didn't"
    }
  end
  
  def test__model_for_projct__non_existing_compiled_project__returns_nil
    assert_nil MicrosatelliteHorizontal.model_for_project(-1)
  end
  
  def test__model__dynamic_columns
    assert_equal(%w[EV1Pma EV1Pmb EV37Mna EV37Mnb], @model.dynamic_column_names) 
  end
end
