class Compiler::MicrosatelliteFinalCompiler < Compiler::MicrosatelliteCompilerBase
  def final?
    true
  end
  
  def results_table_name
    "microsatellites"
  end
  
  def compile_data
    # psuedo algorithm
    organisms_query = QueryBuilder.new(
      :parent => :organisms, 
      :fields => {:organisms => ["id", "project_id", "organism_code"]},
      :filterings => [
        ["organisms", "project_id", "=", @project.id]
      ]
    ).to_sql
    
    microsatellites_query = QueryBuilder.new(
      :parent => "microsatellites", 
      :tables => ["microsatellites", "organisms"], 
      :fields => {:microsatellites => %w[locus allele1 allele2]},
      :filterings => [
        ["microsatellites", "finalResult", "=", true],
        ["organisms", "project_id", "=", @project.id],
        ["organisms", "id", "=", "%s"]
      ]
    ).to_sql
    
    @connection.select_all(organisms_query).each{|organism|
      # insert in the first final microsatellite for each organism
      row = {}
      
      row[:project_id] = organism["organisms_project_id"]
      row[:organism_id] = organism["organisms_id"]
      row[:organism_code] = organism["organisms_organism_code"]
      
      @connection.select_all(microsatellites_query % row[:organism_id]).each{|microsatellite|
        row["#{microsatellite["microsatellites_locus"]}a"] = microsatellite["microsatellites_allele1"]
        row["#{microsatellite["microsatellites_locus"]}b"] = microsatellite["microsatellites_allele2"]
      }
      model.insert(row)
    }
  end
  
  def create_table
    # generate table scchema
    @connection.create_table "microsatellite_final_horizontals_#{@project_id}", :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      
      self.locii.each { |locus|
        t.column "#{locus}a", *column_args(Microsatellite, "allele1")
        t.column "#{locus}b", *column_args(Microsatellite, "allele2")
      }
    end
  end
end