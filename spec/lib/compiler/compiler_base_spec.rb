require File.dirname(__FILE__) + '/../../spec_helper'

describe Compiler::CompilerBase do

  describe :data_exists? do
    before(:each) do
      @project = Factory.create(:project)
      @connection = ActiveRecord::Base.connection
      @compiler = Compiler::CompilerBase.new(@project)

      @compiler.stub!(:results_table_name).and_return('table_name')
    end

    it 'should check the specific compiler table' do
      @connection.should_receive(:select_values).with(/table_name/).and_return([ '0' ])
      @compiler.data_exists?
    end
                                                      
    it 'should only check records for this project' do
      @connection.should_receive(:select_values).with(/where project_id = #{@project.id}/).and_return([ '0' ])
      @compiler.data_exists?
    end

    it 'should return true where count > 0' do
      @connection.stub!(:select_values).and_return([ '1' ])
      @compiler.data_exists?.should == true
    end

    it 'should return true where count == 0' do
      @connection.stub!(:select_values).and_return([ '0' ])
      @compiler.data_exists?.should == false
    end
  end

end
