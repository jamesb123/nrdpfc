class Compiler::YChromosomeFinalCompiler < Compiler::CompilerBase
  def model
    @model ||= YChromosomeFinalHorizontal.model_for_project(@project_id)
  end
  
  def final?
    true
  end
  
  def results_table_name
    "y_chromosomes"
  end
  
  def create_table
    # generate table scchema
    @connection.create_table table_name, :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      
      self.locii.each { |locus|
        t.column "#{locus}", *column_args(YChromosome, "haplotype")
      }
    end
    @connection.add_index table_name, 'organism_id'
  end
  
  def final_y_chromosomes_query
    @final_y_chromosomes_query ||= QueryBuilder.new(
      :parent => :y_chromosomes, 
      :tables => ["y_chromosomes", "organisms"], 
      :fields => {:y_chromosomes => ["locu_id", "haplotype"]}, 
      :filterings => [
        ["y_chromosomes", "finalResult", "=", true],
        ["organisms", "project_id", "=", @project.id],
        ["organisms", "id", "=", "%s"]
      ]).to_sql
  end
    
  def compile_organism(row)
    each(final_y_chromosomes_query % row["organism_id"]) do |y_chromosome|
      locu = locu_col_name(y_chromosome["y_chromosomes_locus"])
      row[locu] ||= y_chromosome["y_chromosomes_haplotype"]
    end
  end
end
