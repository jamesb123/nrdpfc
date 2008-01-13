require File.dirname(__FILE__) + '/../spec_helper'

describe QueryTable do
  fixtures :projects, :organisms, :dynamic_attribute_values
  describe "when working with a 'Normal' model" do
    before(:each) do
      @query_table = QueryTable.new(:project)
    end
    
    it "should diving the model name" do
      @query_table.model.should == Project
    end
  
    it "should query include node  should get model name from relationship" do
      new_node = @query_table.add_child_table(:samples)

      assert_equal("Sample", new_node.class_name)
    end

    it "shouldn't allow non-existing relationship" do
      assert ! @query_table.add_child_table(:sample_non_existing_table_name)
    end

    it "should return all tables in a flattened array" do
      @query_table.add_child_table(:samples).add_child_table(:dna_results)
      @query_table.flatten.keys.map(&:to_s).sort.should == %w[dna_results project samples]
    end
  end
  describe "when joining" do
    it "should return join SQL without using table aliases" do
      samples_table = @query_table.add_child_table(:samples)
      @query_table.join_sql.should == "LEFT JOIN samples ON (samples.project_id = project.id)"
    end
  
    it "should return join SQL when per_project <- normal (microsatellite_horizontals <- samples)"
  
    it "should return join SQL when normal <- per_project (samples <- microsatellite_horizontals)"
    
    it "should return join SQL when crosstab <- normal (organisms <- projects)"
    
    it "should return join SQL when normal <- crosstab (projects <- organisms)"
  end
  
  describe "when querying on a CrossTab model" do
    before(:each) do
      
    end
    it "should description" do
      
    end
  end

  
end
