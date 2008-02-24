require File.dirname(__FILE__) + '/../../spec_helper'

require 'lib/exportables/exportable_model'
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
    Project.exportable_reflections.keys.map(&:to_s).sort.should == ["dna_results", "gender_final_horizontals", "genders", "mhc_final_horizontals", "mhc_seqs", "mhcs", "microsatellite_horizontals", "mt_dna_final_horizontals", "mt_dna_seqs", "mt_dnas", "organisms", "sample_non_tissues", "samples", "y_chromosome_final_horizontals", "y_chromosome_seqs", "y_chromosomes"]
  end
  
  it "should return a valid filter QueryPiece with a where clause" do
    Project.exportable_filter("name", "=", "Whale Project").where.should == ["(projects.name = 'Whale Project')"]
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
  
  it "should tie itself to all possible tables" do
    Project.exportable_join(:samples, [:organisms]).join.should == ["LEFT JOIN samples ON (projects.id = samples.project_id AND organisms.id = samples.organism_id)"]
  end
  
  it "should store all exportable models" do
    exportable_models = Exportables::ExportableModel.models.map(&:to_s).sort.should == ["DnaResult", "ExtractionMethod", "Gender", "GenderFinalHorizontal", "LocalityType", "Mhc", "MhcFinalHorizontal", "MhcSeq", "MicrosatelliteHorizontal", "MtDna", "MtDnaFinalHorizontal", "MtDnaSeq", "Organism", "Project", "Project", "Sample", "Sample", "SampleNonTissue", "Shippingmaterial", "TissueType", "YChromosome", "YChromosomeFinalHorizontal", "YChromosomeSeq"]
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
    (Exportables::ExportableModel.models - [Project]).each do |model|
      it "should find a path to #{model.table_name}" do
        Project.path_to_exportable_table(model.table_name).should_not be_nil
      end
    end
    
    it "should find the shortest path to dna_results" do
      Project.path_to_exportable_table('dna_results').should == [:dna_results]
    end
  end
end