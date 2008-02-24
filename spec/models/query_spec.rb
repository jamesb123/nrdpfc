require File.dirname(__FILE__) + '/../spec_helper'

require "query.rb"

describe Query do
  fixtures :users, :projects, :organisms, :microsatellites, :queries, :dna_results, :samples
  
  before(:each) do
    @query = Query.new :name => "My Query"
  end
  
  it "should default data to {}" do
    @query.data.should == {}
  end
  
  
  describe "when building a QueryBuilder" do
    before(:each) do
      @query.data = {
        :dna_results => {
          :barcode => {
            :select => "true",
            :order => "",
            :filters => { :operator => ["="], :value => ["12345"] }
          },
          :plate => {
            :select => "true",
            :order => "ASC", 
          }
        },
        :organisms => {
          :comment => {
            :select => "true"
          }
        }
      }

      @query_builder = @query.query_builder
    end
    
    it "should include all referenced tables" do
      included_tables = @query_builder.tables.map{|key, table| key.to_s }
      included_tables.should include("dna_results")
      included_tables.should include("organisms")
    end
    
    it "should include all referenced fields" do
      @query_builder.select_field_aliases.map(&:to_s).sort.should == %w[dna_results_barcode dna_results_plate organisms_comment]
    end
    
    it "should exclude empty orderings" do
      @query_builder.order_fields.should == [["dna_results_plate", "ASC"]]
    end
    
    it "should exclude empty filterings" do
      @query_builder.filterings.should == [
        [:dna_results, :barcode, "=", "12345"]
      ]
    end
  end
end
