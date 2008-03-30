class Compiler::MicrosatelliteFinalCompiler < Compiler::MicrosatelliteCompilerBase
  def final?
    true
  end
  
  def results_table_name
    "microsatellites"
  end
  
  def compile_data
    # psuedo algorithm
    
    @project.organisms.each{|organism|
      # insert in the first final microsatellite for each organism
      row = model.new
      
      row.organism_id = organism.id
      row.project_id = organism.project_id
      row.organism_code = organism.organism_code
      
      organism.final_microsatellites.each{|microsatellite|
        row["#{microsatellite.locus}a"] ||= microsatellite.allele1
        row["#{microsatellite.locus}b"] ||= microsatellite.allele2
      }
      row.save
    }
  end
  
  def create_table
    # generate table scchema
    @connection.create_table "microsatellite_final_horizontals_#{@project_id}", :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      
      self.locii.each { |locus|
        t.integer "#{locus}a"
        t.integer "#{locus}b"
      }
    end
  end
end