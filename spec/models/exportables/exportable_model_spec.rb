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
    Set.new(Project.exportable_columns.map(&:name)).should == Set.new(Project.columns.map(&:name))
  end
  
  it "should return a list of all exportable reflections" do
    Project.exportable_reflections.keys.map(&:to_s).sort.should == %w[mt_dna_seqs samples y_chromosome_seqs]
  end
  
  it "should return a hash of it's data types" do
    Project.exportable_table_name
  end
  
  it "should generate sql select elements for columns, with the table alias" do
    Project.select_sql_for("description").should == "`projects`.`description` as `project_description`"
  end
end