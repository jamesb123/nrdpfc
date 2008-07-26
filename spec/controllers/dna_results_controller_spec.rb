require File.dirname(__FILE__) + '/../spec_helper'

describe DnaResultsController do
  describe "on go_to_organism_code" do
    before(:each) do
      @params = {:go_to_organism_code => "CODE123"}
      
      @controller.stub!(:conditions_from_params)
      DnaResult.should_receive(:alphabetical_index_of_organism_code).with("CODE123", nil).and_return(21)
      @controller.active_scaffold_config.stub!(:list).and_return(stub("List", :per_page => 10))
      @controller.stub!(:params).and_return(@params)
      @controller.go_to_organism_code
    end
    
    it "should set the sort order to be on the column with organism_code" do
      @params[:sort].should == "sample"
      @params[:sort_direction].should == "ASC"
    end
    
    it "should set the page number" do
      @params[:page].should == 3
    end
  end
end
