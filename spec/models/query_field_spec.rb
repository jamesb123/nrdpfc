require File.dirname(__FILE__) + '/../spec_helper'

describe QueryField do
  fixtures :projects, :microsatellite_horizontals
  
  before(:each) do
    @project = projects(:whale_project)
    ActiveRecord::Base.current_project_proc = lambda { @project }
  end
  
  describe "for model Project" do
    before(:each) do
      @query_table = QueryTable.new("samples")
      @query_field = QueryField.new("receiver_comments", :table => @query_table)
    end
  
    it "should retrieve valid select_sql using the given model" do
      @query_field.select_sql.select.should == ["`samples`.`receiver_comments` as `samples_receiver_comments`"]
    end
  
    it "should return sort sql if appropriate" # ???
    
    it "should have a field_alias" do
      @query_field.field_alias.should == "samples_receiver_comments"
    end
  end
  
  describe "for model MicrosatelliteHorizontal" do
    before(:each) do
      @query_table = QueryTable.new("microsatellite_horizontals")
      @query_field = QueryField.new("organism_code", :table => @query_table)
    end
    
    it "should render select_sql using the model's field renderer" do
      @query_field.select_sql.select.should == ["`microsatellite_horizontals_#{@project.id}`.`organism_code` as `microsatellite_horizontals_organism_code`"]
    end
  end
  
  describe "for model Organism" do
    fixtures :organisms, :dynamic_attribute_values, :dynamic_attributes, :dynamic_types, :dynamic_classes
    before(:each) do
      @query_table = QueryTable.new("organisms")
      @nea_query_field = QueryField.new("nea", :table => @query_table)
      @notes_query_field = QueryField.new("notes", :table => @query_table)
    end
    
    it "should render select_sql using the model's field renderer" do
      @nea_query_field.select_sql.select.should == ["`organism_dynamic_attribute_nea`.`integer_value` as organisms_nea"]
    end
    
    it "should render select_sql using the model's field renderer" do
      @notes_query_field.select_sql.select.should == ["`organism_dynamic_attribute_notes`.`text_value` as organisms_notes"] #{}"max( if(dynamic_attribute_values.dynamic_attribute_id = #{dynamic_attributes(:notes).id}, text_value, null) ) as organisms_notes"
    end
    
    
  end
end
