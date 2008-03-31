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
    organism_query = QueryBuilder.new(
      :parent => :organism, 
      :fields => {:organisms => ["id", "project_id", "organism_code"]},
      :filterings => [
        ["organisms", "project_id", "=", @project.id]
      ]
    ).to_sql
    mt_dna_query = QueryBuilder.new(
      :parent => :organism, 
      :tables => ["mt_dnas"], 
      :fields => {:mt_dnas => ["locus", "haplotype"]}, 
      :filterings => [
        ["mt_dnas", "finalResult", "=", true],
        ["organisms", "project_id", "=", @project.id],
        ["organisms", "id", "=", "%s"]
      ]).to_sql
    
    @connection.select_all(organism_query).each{|organism|
      # insert in the first final mt_dna for each organism
      row = {}
      
      row[:organism_id] = organism["organisms_id"]
      row[:project_id] = organism["organisms_project_id"]
      row[:organism_code] = organism["organisms_organism_code"]
      
      @connection.select_all( mt_dna_query % row[:organism_id] ).each{|mt_dna|
        row[mt_dna["mt_dnas_locus"]] ||= mt_dna["mt_dnas_haplotype"]
      }
      model.insert(row)
    }
  end
  
end
