require File.dirname(__FILE__) + '/../../spec_helper'

require 'lib/exportables/exportable_model'
require "sample.rb"
require "project.rb"

describe Exportables::ExportableModel, "in Sample" do
  it "should be exportable" do
    Sample.exportable?.should be_true
  end
  
  it "should return it's table name" do
    Sample.exportable_table_name.should == "samples"
  end
  
  it "should return a copy of its columns" do
    Set.new(Sample.exportable_fields).should == Set.new(Sample.columns.map(&:name))
  end
  
  it "should return a list of all exportable reflections" do
    relationships = Sample.exportable_reflections.keys.map(&:to_s).sort
    relationships.should include("dna_results")
    relationships.should include("extraction_method")
  end
  
  it "should return a valid filter QueryPiece with a where clause" do
    Sample.exportable_filter("receiver_comments", "=", "Fin sample").where.should == ["(`samples`.`receiver_comments` = 'Fin sample')"]
  end
  
  it "should return a hash of it's data types" do
    Gender.exportable_column_types_hash.should == {
      "project_id"  => :integer,
      "comments"    => :text,
      "gelNum"      => :string,
      "gender"      => :string,
      "id"          => :integer,
      "wellNum"     => :string,
      "locu_id"     => :integer,
      "locus"       => :string,
      "finalResult" => :boolean,
      "sample_id"   => :integer
    }
  end
  
  it "should return a join based off a parent join" do
    Sample.exportable_join(:organism).join.should == ["LEFT JOIN organisms ON (organisms.id = samples.organism_id)"]
  end
  # not applicable anymore
  # it "should tie itself to all possible tables" do
  #   
  # end
  
  it "should store all exportable models" do
    models = exportable_models = Exportables::ExportableModel.models.map(&:to_s).sort
    
    models.should include("DnaResult")
    models.should include("Sample")
    models.should include("Organism")
  end
  
  it "should have reverse associations for all exportable_reflections" do
    errors = []
    Exportables::ExportableModel.models.each do |model|
      model.exportable_reflections.values.each do |reflection|
        has_reverse = reflection.class_name.constantize.exportable_reflections.values.any? do |reverse_reflection|
          reverse_reflection.class_name == model.to_s
        end
        errors << "#{model.to_s}##{reflection.name} is missing reverse association on #{reflection.class_name}" unless has_reverse
      end
    end
    
    assert(errors.empty?, errors.uniq * "\n")
  end
  
  
  describe "when finding shortest path" do
    (Exportables::ExportableModel.models - [Sample]).each do |model|
      it "should find a path to #{model.table_name}" do
        Sample.path_to_exportable_table(model.table_name).should_not be_nil
      end
    end
    
    it "should find the shortest path to dna_results" do
      Sample.path_to_exportable_table('dna_results').should == [:dna_results]
    end
  end
end
