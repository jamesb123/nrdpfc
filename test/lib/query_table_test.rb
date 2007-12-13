require File.dirname(__FILE__) + '/../test_helper'

class QueryTableTest < Test::Unit::TestCase
  def setup
    @qin = QueryTable.new(:project, :class_name => "Project")
  end
  
  def test__query_include_node__should_get_model_name_from_relationship
    new_node = @qin.add_child_table(:samples)
    
    assert_equal("Sample", new_node.class_name)
  end
  
  def test__query_include_node__shouldnt_allow_non_existing_relationship_to_be_added
    assert ! @qin.add_child_table(:sample_silly)
  end
  
  def test__all_tables__nested_tables__returns_all_in_flattened_array
    @qin.add(:samples).add_child_table(:dna_results)
    assert_equal(
      %w[dna_results project samples], 
      @qin.flatten.keys.map(&:to_s).sort
    )
  end
  
  def test__join_sql__should_formulate_with_alias
    samples_table = @qin.add_child_table(:samples)
    assert_similar("LEFT JOIN samples ON (samples.project_id = project.id)", @qin.join_sql)
  end
  
protected
  def assert_similar(expected, result, message = nil)
    gsub_args = [/[ \n]+/, " "]
    assert_equal(expected.gsub(*gsub_args), actual.gsub(*gsub_args), message)
  end
end