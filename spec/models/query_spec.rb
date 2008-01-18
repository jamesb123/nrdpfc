require File.dirname(__FILE__) + '/../spec_helper'

require "query.rb"

describe Query do
  fixtures :users, :projects, :organisms, :microsatellites, :queries, :dna_results, :samples
  
  before(:each) do
    @query = Query.new :name => "My Query"
  end
  
end
