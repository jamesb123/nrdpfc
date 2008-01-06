require File.dirname(__FILE__) + '/../../spec_helper'

require "sample.rb"
require "project.rb"
describe Exportables::DynamicAttributesExportableModel, "in Organism" do
  fixtures :projects
  
  before(:each) do
    @project = projects(:whale_project)
    ActiveRecord::Base.current_project_proc = lambda{@project}
    
  end
  
  it "should be exportable" do
    Organism.exportable?.should be_true
  end
  
  it "should have a table name selected according to the current project" do
    Organism.exportable_table_name.should == "organisms"
  end
  
  it "should return a exportable_table_alias" do
    Organism.exportable_table_alias.should == "organisms"
  end
  
  it "should return a exportable_table_with_alias" do
    Organism.exportable_table_with_alias.should == "organisms"
  end
  
  
  it "should return a copy of its columns" do
    Set.new(Project.exportable_columns.map(&:name)).should == Set.new(Project.columns.map(&:name))
  end
  
  it "should return a list of all exportable reflections" do
    Organism.exportable_reflections.keys.map(&:to_s).sort.should == %w[project samples]
  end
  
  it "should return a hash of it's data types" do
    Organism.exportable_table_name
  end
  
  it "should generate sql select elements for columns, with the table alias" do
    Organism.select_sql_for("description").should == "`organisms`.`description` as `organism_description`"
  end
end