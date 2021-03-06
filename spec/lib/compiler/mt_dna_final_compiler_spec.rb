require File.dirname(__FILE__) + '/../../spec_helper'

describe Compiler::MtDnaFinalCompiler do
  fixtures :projects, :mt_dnas, :samples, :organisms
  def setup
    @project =  projects(:whale_project)
    @project_id = @project.id
    
    @compiler = Compiler::MtDnaFinalCompiler.new(@project_id)
    @compiler.create_table
    restart_transaction
    
    @table_name = "mt_dna_final_horizontals_#{@project_id}"
    @model = MtDnaFinalHorizontal.model_for_project(@project)
  end
  
  it "should create_table_for_project__should_create" do
    @compiler.create_table
    
    tables = Project.connection.select_values("show tables")
    assert tables.include?(@table_name)
    
    fields = Project.connection.select_all("show columns from #{@table_name}").map{|h| h["Field"]}
    
    @project.mt_dnas.each{|m|
      fields.should include(m.locu.locus)
    }
  end
  
  it "should compile_data" do
    @compiler.compile
    @results = @model.find(:all)
    
    @results.each{|result|
      ["Control_Region", "Cyt_b"].each{|col_name|
        assert_not_nil(result[col_name], "Expected data for #{col_name} - organism - #{result.organism.organism_code}")
      }
      assert_not_nil(result.project_id)
      assert_not_nil(result.organism_id)
      assert_not_nil(result.organism_code)
    }
    assert_equal(1, @results.length)
    
  end
end
 
