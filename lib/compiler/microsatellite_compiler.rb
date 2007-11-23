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
      row = model.new
      
      row.project_id = sample.project_id
      row.sample_id = sample.id
      row.org_sample = sample.org_sample
      row.organism_code = sample.organism_code
      
      sample.microsatellites.each{|microsatellite|
        row["#{microsatellite.locus}a"] = microsatellite.allele1
        row["#{microsatellite.locus}b"] = microsatellite.allele2
      }
      row.save
    }
  end
  
  def create_table
    # generate table scchema
    ActiveRecord::Base.connection.create_table "microsatellite_horizontals_#{@project_id}", :force => true do |t|
      t.integer :project_id
      t.integer :sample_id
      t.integer :organism_code
      t.integer :org_sample
      t.integer :extraction_number
      
      self.locii.each { |locus|
        t.integer "#{locus}a"
        t.integer "#{locus}b"
      }
    end
    
  end
end