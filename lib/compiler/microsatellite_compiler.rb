class Compiler::MicrosatelliteCompiler < Compiler::MicrosatelliteCompilerBase
  def final?
    false
  end
  
  def results_table_name
    "microsatellites"
  end
  
  def compile_data
    # psuedo algorithm
    @project.samples.each{|sample|
      row = {}
      
      row[:project_id] = sample.project_id
      row[:sample_id] = sample.id
      row[:organism_index] = sample.organism_index
      
      sample.microsatellites.each { |microsatellite|
        row["#{microsatellite.locus}a"] = microsatellite.allele1
        row["#{microsatellite.locus}b"] = microsatellite.allele2
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