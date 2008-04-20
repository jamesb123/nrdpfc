require File.dirname(__FILE__) + '/../spec_helper'

describe DnaResult do
  scenario :expanded
  it "should return the alphabetical index of a given organism code" do
    DnaResult.alphabetical_index_of_organism_code("Egl00060").should > DnaResult.alphabetical_index_of_organism_code("Egl00050")
  end
end
