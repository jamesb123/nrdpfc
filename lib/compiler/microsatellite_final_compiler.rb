class Compiler::MicrosatelliteFinalCompiler < Compiler::CompilerBase
  def final?
    true
  end
  
  def results_table_name
    "microsatellites"
  end
  
  # psuedo algorithm
  def organisms_query
    @organisms_query ||= QueryBuilder.new(
      :parent => :organisms, 
      :fields => {:organisms => ["id", "project_id", "organism_code"]},
      :filterings => [
        ["organisms", "project_id", "=", @project.id]
      ]
    ).to_sql
  end
    
  def microsatellites_query
    @microsatellites_query ||= QueryBuilder.new(
      :parent => "microsatellites", 
      :tables => ["microsatellites", "organisms"], 
      :fields => {:microsatellites => %w[locu_id allele1 allele2]},
      :filterings => [
        ["microsatellites", "finalResult", "=", true],
        ["microsatellites", "FinalSampleResult", "=", true],
        ["organisms", "project_id", "=", @project.id],
        ["organisms", "id", "=", "%s"]
      ]
    ).to_sql
  end
    
  def compile_organism(row)
    each(microsatellites_query % row[:organism_id]) do |microsatellite|
      locu = locu_col_name(microsatellite["microsatellites_locu_id"])
      row["#{locu}a"] = microsatellite["microsatellites_allele1"]
      row["#{locu}b"] = microsatellite["microsatellites_allele2"]
    end
  end
  
  def create_table
    # generate table scchema
    @connection.create_table table_name, :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      
      self.locii.each { |locus|
        t.column "#{locus}a", *column_args(Microsatellite, "allele1")
        t.column "#{locus}b", *column_args(Microsatellite, "allele2")
      }
    end
    @connection.add_index table_name, 'organism_id'
  end
end
