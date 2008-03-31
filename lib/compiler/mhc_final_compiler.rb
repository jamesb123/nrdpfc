class Compiler::MhcFinalCompiler < Compiler::CompilerBase
  def final?
    true
  end
  
  def results_table_name
    "mhcs"
  end

  def create_table
    # generate table scchema
    @connection.create_table "mhc_final_horizontals_#{@project_id}", :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      
      self.locii.each { |locus|
        t.column "#{locus}a", Mhc.columns_hash["allele1"].type, :limit => Mhc.columns_hash["allele1"].limit
        t.column "#{locus}b", Mhc.columns_hash["allele2"].type, :limit => Mhc.columns_hash["allele2"].limit
      }
    end
  end
  

  def compile_data
    @project.organisms.each{|organism|
      # insert in the first final mhc for each organism
      row = {}
      
      row[:organism_id] = organism.id
      row[:project_id] = organism.project_id
      row[:organism_code] = organism.organism_code
      
      organism.final_mhcs.each{|mhc|
        row["#{mhc.locus}a"] ||= mhc.allele1
        row["#{mhc.locus}b"] ||= mhc.allele2
      }
      model.insert(row)
    }
  end
end
