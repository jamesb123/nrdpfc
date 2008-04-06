require File.dirname(__FILE__) + '/../spec_helper'

describe "ActiveRecord insert query" do
  it "should typecast data appropriately" do
    Microsatellite.columns_hash["allele1"].type.should == :integer
    Microsatellite.insert_query_for(:allele1 => "").should == "INSERT INTO microsatellites set `allele1` = NULL"
    Microsatellite.insert_query_for(:allele1 => "a").should == "INSERT INTO microsatellites set `allele1` = 0"
  end
end