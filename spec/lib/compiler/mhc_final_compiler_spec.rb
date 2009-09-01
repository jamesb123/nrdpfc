require File.dirname(__FILE__) + '/../../spec_helper'

describe Compiler::MhcFinalCompiler do
  fixtures :projects, :mhcs, :samples, :organisms, :locus
  def setup
    @project =  projects(:whale_project)
    @project_id = @project.id
    
    @compiler = Compiler::MhcFinalCompiler.new(@project_id)
    @compiler.create_table
    restart_transaction
    
    @table_name = "mhc_final_horizontals_#{@project_id}"
    @model = MhcFinalHorizontal.model_for_project(@project)
  end
  
  it "should create_table_for_project__should_create" do
    @compiler.create_table
    
    tables = Project.connection.select_values("show tables")
    tables.should include(@table_name)
    
    fields = Project.connection.select_all("show columns from #{@table_name}").map{|h| h["Field"]}
    
    @project.mhcs.each{|m|
      locus = m.locu.locus
      fields.should include("#{locus}a")
      fields.should include("#{locus}b")
    }
  end
  
  it "should compile_data" do
    @compiler.compile
    @results = @model.find(:all)
    
    @results.each{|result|
      %w[EV31Mna EV0Pma EV31Mnb EV0Pmb].each{|col_name|
        assert_not_nil(result[col_name], "Expected data for #{col_name} - organism - #{result.organism.organism_code}")
      }
      assert_not_nil(result.project_id)
      assert_not_nil(result.organism_id)
      assert_not_nil(result.organism_code)
    }
    assert_equal(1, @results.length)
    
  end
end
 
