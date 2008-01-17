require File.dirname(__FILE__) + '/../../spec_helper'

require "sample.rb"
require "project.rb"
describe Exportables::ExportableModel, "in Project" do
  it "should be exportable" do
    Project.exportable?.should be_true
  end
  
  it "should return it's table name" do
    Project.exportable_table_name.should == "projects"
  end
  
  it "should return a copy of its columns" do
    Set.new(Project.exportable_fields).should == Set.new(Project.columns.map(&:name))
  end
  
  it "should return a list of all exportable reflections" do
    Project.exportable_reflections.keys.map(&:to_s).sort.should == %w[mt_dna_seqs organisms samples y_chromosome_seqs]
  end
  
  it "should return a hash of it's data types" do
    Project.exportable_column_types_hash.should == {
      "name" => :string, 
      "code" => :string, 
      "id" => :integer, 
      "description" => :string, 
      "recompile_required" => :boolean,
      "user_id" => :integer
    }
  end
  
  it "should return a join based off a parent join" do
    Project.exportable_join(:samples).join.should == ["LEFT JOIN samples ON (projects.id = samples.project_id)"]
    Sample.exportable_join(:project).join.should == ["LEFT JOIN projects ON (projects.id = samples.project_id)"]
  end
  
  it "should return select sql"
  
end