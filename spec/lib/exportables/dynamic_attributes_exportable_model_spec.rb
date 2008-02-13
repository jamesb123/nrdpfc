require File.dirname(__FILE__) + '/../../spec_helper'

require "sample.rb"
require "project.rb"

describe Exportables::DynamicAttributesExportableModel, "in Organism" do
  fixtures :projects, :organisms, :dynamic_attributes, :dynamic_attribute_values, :dynamic_classes, :dynamic_types
  
  before(:each) do
    @project = projects(:whale_project)
    ActiveRecord::Base.current_project_proc = lambda{ @project }
    
    @dynamic_attributes = DynamicAttribute.find(:all, :conditions => ["scoper_type = 'Project' and scoper_id = ? and owner_type = 'Organism'", @project.id])
  end
  
  it "should be exportable" do
    Organism.exportable?.should be_true
  end
  
  it "should have a table name selected according to the current project" do
    Organism.exportable_table_name.should == "organisms"
  end
  
  it "should return a exportable_name" do
    Organism.exportable_name.should == "organisms"
  end
  
  it "should return a copy of its columns, including dynamic attributes" do
    Set.new(Organism.exportable_fields).should == Set.new(Organism.columns.map(&:name) + @dynamic_attributes.map(&:name))
  end
  
  it "should return a list of all exportable reflections" do
    Organism.exportable_reflections.keys.map(&:to_s).sort.should == ["project", "sample_non_tissues", "samples"] 
  end
  
  it "should return a hash of it's data types" do
    Organism.exportable_column_types_hash.should == {
      "id"            => :integer,
      "project_id"    => :integer,
      "organism_code" => :string,
      "comment"       => :string,
      "nea"           => :integer,
      "notes"         => :text_value
    }
  end
  
  it "should generate sql select elements for columns, with the table alias" do
    Organism.exportable_select("description").select.should == ["`organisms`.`description` as `organisms_description`"]
  end
  
  it "should generate sql select elements for dynamic columns (integer_value), with the table alias" do
    query_piece = Organism.exportable_select("nea")
    query_piece.select.should == ["`organism_dynamic_attribute_nea`.`integer_value` as organisms_nea"]
    query_piece.join.should == [
      "LEFT JOIN dynamic_attribute_values as organism_dynamic_attribute_nea ON (organism_dynamic_attribute_nea.owner_type = 'Organism' and organism_dynamic_attribute_nea.owner_id = organisms.id and organism_dynamic_attribute_nea.dynamic_attribute_id = #{dynamic_attributes(:nea).id})"
    ]
  end
  
  it "should generate sql select elements for dynamic columns (text_value), with the table alias" do
    query_piece = Organism.exportable_select("notes")
    query_piece.select.should == ["`organism_dynamic_attribute_notes`.`text_value` as organisms_notes"]
    query_piece.join.should == [
      "LEFT JOIN dynamic_attribute_values as organism_dynamic_attribute_notes ON (organism_dynamic_attribute_notes.owner_type = 'Organism' and organism_dynamic_attribute_notes.owner_id = organisms.id and organism_dynamic_attribute_notes.dynamic_attribute_id = #{dynamic_attributes(:notes).id})" 
    ]
  end
  
  it "should join in properly when asking to join it in from a parent model" do
    Project.exportable_join(:organisms).join.should == [
      "LEFT JOIN organisms ON (projects.id = organisms.project_id)"
    ]
  end
end