require File.dirname(__FILE__) + '/../../spec_helper'

describe Compiler::MicrosatelliteCompiler do
  fixtures :projects, :microsatellites, :samples
  before(:each) do
    @project =  projects(:whale_project)
    @project_id = @project.id
    
    @compiler = Compiler::MicrosatelliteCompiler.new(@project)
    @compiler.create_table
    restart_transaction
    
    @table_name = "microsatellite_horizontals_#{@project_id}"
    @model = MicrosatelliteHorizontal.model_for_project(@project)
  end
  
  it "should create the table for the project" do
    tables = Project.connection.select_values("show tables")
    assert tables.include?(@table_name)
  end
  
  it "should create a table for a project using only the locus values for the given" do
    fields = Project.connection.select_all("show columns from #{@table_name}").map{|h| h["Field"]}
    
    @project.microsatellites.each{|m|
      locus = m.locu.locus
      fields.should include("#{locus}a")
      fields.should include("#{locus}b")
    }
  end
  
  it "should ignore locus for other projects" do
    Microsatellite.update_all("project_id = #{@project_id + 1}")
  
    # clear the cache
    @compiler.instance_variable_set("@locii", nil)

    @compiler.unique_locu_ids.should == []
    @compiler.locii.should == []
  end
  
  it "should compile_data" do
    @compiler.compile_data
    @results = @model.find(:all)
#    y @results
    
    @results.each{|result|
      %w[EV1Pma EV1Pmb EV37Mna EV37Mnb].each{|col_name|
        assert_not_nil(result[col_name], "Expected data for #{col_name} - sample - #{result.sample.receiver_comments}")
      }
      assert_not_nil(result.project_id)
      assert_not_nil(result.sample_id)
      assert_not_nil(result.organism_index)
    }
    assert_equal(2, @results.length)
  end
end
 
