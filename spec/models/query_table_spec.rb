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
    
    it "should return select_sql for a specified field" do
      @query_table.select_sql("name").select.should == ["`projects`.`name` as `projects_name`"]
      
    end
  
    it "should query include node  should get model name from relationship" do
      new_node = @query_table.add_association(:samples)

      assert_equal("Sample", new_node.class_name)
    end

    it "shouldn't allow non-existing relationship" do
      lambda {@query_table.add_association(:sample_non_existing_table_name)}.should raise_error(ArgumentError, "association sample_non_existing_table_name non-existant for Project")
    end

    it "should return all tables in a flattened array" do
      @query_table.add_association(:samples).add_association(:dna_results)
      @query_table.flatten.keys.map(&:to_s).sort.should == %w[dna_results project samples]
    end
  end
  
  describe "when joining from Samples" do
    before(:each) do
      @query_table = QueryTable.new(:samples)  
    end
    
    it "should return join SQL without using table aliases" do
      projects_table = @query_table.add_association(:project)
      projects_table.model.should == Project
      @query_table.joins.join.should == ["LEFT JOIN projects ON (projects.id = samples.project_id)"]
    end
    
    it "should return exportable associations" do
      @query_table.association_names.should == ["dna_results", "extraction_method", "final_genders", "final_mhcs", "genders", "locality_type", "mhcs", "microsatellite_horizontals", "organism", "project", "shippingmaterial", "tissue_type"]
    end
    
    it "should recurse joins" do
      projects_table = @query_table.add_association(:project)
      projects_table.model.should == Project
      organisms_table = projects_table.add_association(:organisms)
      organisms_table.model.should == Organism
      
      @query_table.joins.join.should == [
        "LEFT JOIN projects ON (projects.id = samples.project_id)",
        "LEFT JOIN organisms ON (projects.id = organisms.project_id)"
      ]
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
