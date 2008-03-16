require File.dirname(__FILE__) + '/../spec_helper'

describe QueryTable do
  fixtures :projects, :organisms, :dynamic_attribute_values
  describe "when working with a 'Normal' model" do
    before(:each) do
      @query_table = QueryTable.new(:samples)
    end
    
    it "should diving the model name" do
      @query_table.model.should == Sample
    end
    
    it "should return select_sql for a specified field" do
      @query_table.select_sql("receiver_comments").select.should == ["`samples`.`receiver_comments` as `samples_receiver_comments`"]
    end
  
    it "should query include node  should get model name from relationship" do
      new_node = @query_table.add_association(:organism)

      assert_equal("Organism", new_node.class_name)
    end

    it "shouldn't allow non-existing relationship" do
      lambda {@query_table.add_association(:sample_non_existing_table_name)}.should raise_error(ArgumentError, "association sample_non_existing_table_name non-existant for Sample")
    end

    it "should return all tables in a flattened array" do
      @query_table.add_association(:dna_results)
      @query_table.flatten.keys.map(&:to_s).sort.should == %w[dna_results samples]
      @query_table.all_table_names.should == %w[samples dna_results]
    end
  end
  
  describe "when joining from Samples" do
    before(:each) do
      @query_table = QueryTable.new(:samples)  
    end
    
    it "should return join SQL without using table aliases" do
      organisms_table = @query_table.add_association(:organism)
      organisms_table.model.should == Organism
      @query_table.joins.join.should == ["LEFT JOIN organisms ON (organisms.id = samples.organism_id)"]
    end
    
    it "should return exportable associations" do
      @query_table.association_names.should == ["dna_results", "extraction_method", "genders", "locality_type", "mhcs", "microsatellite_horizontals", "mt_dnas", "organism", "shippingmaterial", "tissue_type", "y_chromosome_seqs", "y_chromosomes"]
    end
    
    # currently, no use case for this now
    # it "should recurse joins" do
    #   projects_table = @query_table.add_association(:organisms)
    #   projects_table.model.should == Project
    #   organisms_table = projects_table.add_association(:organisms)
    #   organisms_table.model.should == Organism
    #   
    #   @query_table.joins.join.should == [
    #     "LEFT JOIN projects ON (projects.id = samples.project_id)", 
    #     "LEFT JOIN organisms ON (projects.id = organisms.project_id AND organisms.id = samples.organism_id)"
    #   ]
    # end
  
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
