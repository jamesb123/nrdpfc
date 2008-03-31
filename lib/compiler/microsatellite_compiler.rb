class Compiler::MicrosatelliteCompiler < Compiler::MicrosatelliteCompilerBase
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
      :fields => {:microsatellites => %w[locus allele1 allele2]},
      :filterings => [
        ["samples", "project_id", "=", @project.id],
        ["samples", "id", "=", "%s"]
      ]
    )
  end
  
  def compile_data
    samples_query = sample_query_builder.to_sql
    microsatellites_query = microsatellites_query_builder.to_sql
    
    # psuedo algorithm
    @connection.select_all(samples_query).each{|sample|
      row = {}
      
      row[:project_id] = sample["samples_project_id"]
      row[:sample_id] = sample["samples_id"]
      row[:organism_index] = sample["samples_organism_index"]
      
      @connection.select_all(microsatellites_query % row[:sample_id]).each { |microsatellite|
        row["#{microsatellite["microsatellites_locus"]}a"] = microsatellite["microsatellites_allele1"]
        row["#{microsatellite["microsatellites_locus"]}b"] = microsatellite["microsatellites_allele2"]
      }
      
      model.insert(row)
    }
  end
  
  def create_table
    # generate table scchema
    ActiveRecord::Base.connection.create_table "microsatellite_horizontals_#{@project_id}", :force => true do |t|
      t.integer :project_id
      t.integer :sample_id
      t.integer :organism_index
      
      self.locii.each { |locus|
        t.column "#{locus}a", *column_args(Microsatellite, "allele1")
        t.column "#{locus}b", *column_args(Microsatellite, "allele2")
      }
    end
    
  end
end