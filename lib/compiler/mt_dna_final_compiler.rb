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
    @connection.add_index table_name, 'organism_id'
  end
  
  def mt_dna_query
    @mt_dna_query ||= QueryBuilder.new(
      :parent => :mt_dnas, 
      :tables => ["mt_dnas", "organisms"], 
      :fields => {:mt_dnas => ["locu_id", "haplotype"]}, 
      :filterings => [
        ["mt_dnas", "finalResult", "=", true],
        ["organisms", "project_id", "=", @project.id],
        ["organisms", "id", "=", "%s"]
      ]).to_sql
  end
    

  def compile_organism(row)
    each(mt_dna_query % row[:organism_id]) do |mt_dna|
      locu = locu_col_name(mt_dna["mt_dnas_locu_id"])
      row[locu] ||= mt_dna["mt_dnas_haplotype"]
    end
  end
  
end
