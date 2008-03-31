class Compiler::MtDnaFinalCompiler < Compiler::CompilerBase
  def results_table_name
    "mt_dnas"
  end
  
  def final?
    true
  end
  
  def create_table
    # generate table scchema
    @connection.create_table table_name, :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      
      self.locii.each { |locus|
        t.string "#{locus}"
      }
    end
  end
  
  def compile_data
    mt_dna_query = QueryBuilder.new(
      :parent => :mt_dnas, 
      :tables => ["mt_dnas", "organisms"], 
      :fields => {:mt_dnas => ["locus", "haplotype"]}, 
      :filterings => [
        ["mt_dnas", "finalResult", "=", true],
        ["organisms", "project_id", "=", @project.id],
        ["organisms", "id", "=", "%s"]
      ]).to_sql
    
    create_row_for_each_organism do |row|
      @connection.select_all( mt_dna_query % row["organism_id"] ).each{|mt_dna|
        row[mt_dna["mt_dnas_locus"]] ||= mt_dna["mt_dnas_haplotype"]
      }
    end
  end
  
end
