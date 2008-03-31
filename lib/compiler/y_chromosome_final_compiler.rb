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
  end
  
  def compile_data
    final_y_chromosomes_query = QueryBuilder.new(
      :parent => :y_chromosomes, 
      :tables => ["y_chromosomes", "organisms"], 
      :fields => {:y_chromosomes => ["locus", "haplotype"]}, 
      :filterings => [
        ["y_chromosomes", "finalResult", "=", true],
        ["organisms", "project_id", "=", @project.id],
        ["organisms", "id", "=", "%s"]
      ]).to_sql
    
    create_row_for_each_organism do |row|
      @connection.select_all( final_y_chromosomes_query % row["organism_id"] ).each{|y_chromosome|
        row[y_chromosome["y_chromosomes_locus"]] ||= y_chromosome["y_chromosomes_haplotype"]
      }
    end
  end
end
