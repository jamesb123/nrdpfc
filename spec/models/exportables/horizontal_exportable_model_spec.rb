require File.dirname(__FILE__) + '/../../spec_helper'

require "sample.rb"
require "project.rb"
describe Exportables::HorizontalExportableModel, "in MicrosatelliteHorizontal" do
  fixtures :projects
  
  before(:each) do
    @project = projects(:whale_project)
    ActiveRecord::Base.current_project_proc = lambda{@project}
    Compiler::MicrosatelliteCompiler.new(@project).create_table
  end
  
  it "should be exportable" do
    MicrosatelliteHorizontal.exportable?.should be_true
  end
  
  it "should have a table name selected according to the current project" do
    MicrosatelliteHorizontal.exportable_table_name.should == "microsatellite_horizontals_#{@project.id}"
  end
  
  it "should return a exportable_table_alias" do
    MicrosatelliteHorizontal.exportable_table_alias.should == "microsatellite_horizontals"
  end
  
  it "should return a exportable_table_with_alias" do
    MicrosatelliteHorizontal.exportable_table_with_alias.should == "microsatellite_horizontals_#{@project.id} microsatellite_horizontals"
  end
  
  it "should return a copy of its columns" do
    Set.new(Project.exportable_columns.map(&:name)).should == Set.new(Project.columns.map(&:name))
  end
  
  it "should return a list of all exportable reflections" do
    MicrosatelliteHorizontal.exportable_reflections.keys.map(&:to_s).sort.should == %w[project sample]
  end
  
  it "should return a hash of it's data types" do
    MicrosatelliteHorizontal.exportable_table_name
  end
  
  it "should generate sql select elements for columns, with the table alias" do
    MicrosatelliteHorizontal.select_sql_for("description").should == "`microsatellite_horizontals`.`description` as `microsatellite_horizontal_description`"
  end
end