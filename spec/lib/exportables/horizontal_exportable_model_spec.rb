require File.dirname(__FILE__) + '/../../spec_helper'

require "sample.rb"
require "project.rb"
describe Exportables::HorizontalExportableModel, "in MicrosatelliteHorizontal" do
  fixtures :projects
  
  before(:each) do
    @project = projects(:whale_project)
    ActiveRecord::Base.current_project_proc = lambda{@project}
    Compiler::MicrosatelliteCompiler.new(projects(:whale_project)).create_table
  end
  
  it "should be exportable" do
    MicrosatelliteHorizontal.exportable?.should be_true
  end
  
  it "should have a table name selected according to the current project" do
    MicrosatelliteHorizontal.exportable_table_name.should == "microsatellite_horizontals_#{@project.id}"
  end
  
  it "should return a exportable_name" do
    MicrosatelliteHorizontal.exportable_name.should == "microsatellite_horizontals"
  end
  
  it "should return a copy of its columns" do
    Set.new(MicrosatelliteHorizontal.exportable_fields).should == Set.new(MicrosatelliteHorizontal.model_for_project(@project).columns.map(&:name))
  end
  
  it "should return a list of all exportable reflections" do
    MicrosatelliteHorizontal.exportable_reflections.keys.map(&:to_s).sort.should == %w[project sample]
  end
  
  it "should return a hash of it's data types" do
    MicrosatelliteHorizontal.exportable_table_name
  end
  
  it "should generate sql select elements for columns, with the table alias" do
    MicrosatelliteHorizontal.exportable_select("description").select[0].should == "`microsatellite_horizontals_492194273`.`description` as `microsatellite_horizontals_description`"
  end
  
  it "should generate a join properly when communicating with this type of model (using the proper table name)" do
    Sample.exportable_join(:microsatellite_horizontals).join.should == ["LEFT JOIN microsatellite_horizontals_#{@project.id} ON (samples.id = microsatellite_horizontals_#{@project.id}.sample_id)"]
    MicrosatelliteHorizontal.exportable_join(:sample).join.should == ["LEFT JOIN samples ON (samples.id = microsatellite_horizontals_#{@project.id}.sample_id)"]
  end
end