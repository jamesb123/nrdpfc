require File.dirname(__FILE__) + '/../../test_helper'
require "compiler.rb"
class CompilerTest < Test::Unit::TestCase
  fixtures :projects, :microsatellites, :samples
  def setup
    @project =  projects(:whale_project)
    @project_id = @project.id
    @connection = ActiveRecord::Base.connection
  end
  
  def test__compile__should_reset_recompile_required_flag
    @project.recompile_required = true
    @project.save
    @project.reload
    assert @project.recompile_required
    Compiler.compile_project @project
    @project.reload
    assert ! @project.recompile_required
  end
  
  def test__compile__should_generate_all_tables
    @expected_tables = %w[microsatellite_horizontals microsatellite_final_horizontals mt_dna_final_horizontals y_chromosome_final_horizontals gender_final_horizontals].map{|table_name| "#{table_name}_#{@project_id}" }
    
    @expected_tables.each{|table_name|
      @connection.execute("DROP TABLE IF EXISTS #{table_name}")
    }
    Compiler.compile_project @project
    
    tables = @connection.select_values("show tables")
    @expected_tables.each{|table_name|
      assert tables.include?(table_name), "Should have created table #{table_name}"
    }
  end
end