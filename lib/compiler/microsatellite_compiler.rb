class Compiler::MicrosatelliteCompiler < Compiler::CompilerBase
  def final?
    false
  end
  
  def results_table_name
    "microsatellites"
  end
  
  def sample_query_builder
    QueryBuilder.new(
      :parent => :samples, 
      :fields => {:samples => ["id", "project_id", "organism_index"]},
      :filterings => [
        ["samples", "project_id", "=", @project.id]
      ]
    )
  end
  
  def microsatellites_query_builder
    QueryBuilder.new(
      :parent => :microsatellites, 
      :tables => %w[microsatellites samples], 
      :fields => {:microsatellites => %w[locu_id allele1 allele2]},
      :filterings => [
        ["samples", "project_id", "=", @project.id],
        ["samples", "id", "=", "%s"]
      ]
    )
  end
  
  def compile_data
    microsatellites_query = microsatellites_query_builder.to_sql
    
    # psuedo algorithm
    sample_query_builder.bulk_records do |sample|
      row = {}
      
      row[:project_id] = sample["samples_project_id"]
      row[:sample_id] = sample["samples_id"]
      row[:organism_index] = sample["samples_organism_index"]
      
      each(microsatellites_query % row[:sample_id]) do |microsatellite|
        locu = locu_col_name(microsatellite["microsatellites_locu_id"])
        row["#{locu}a"] = microsatellite["microsatellites_allele1"]
        row["#{locu}b"] = microsatellite["microsatellites_allele2"]
      end
      
      model.insert(row)
    end
  end
  
  def create_table
    # generate table scchema
    ActiveRecord::Base.connection.create_table table_name, :force => true do |t|
      t.integer :project_id
      t.integer :sample_id
      t.integer :organism_index
      
      self.locii.each { |locus|
        t.column "#{locus}a", *column_args(Microsatellite, "allele1")
        t.column "#{locus}b", *column_args(Microsatellite, "allele2")
      }
    end
    @connection.add_index table_name, 'sample_id'
    
  end
end
