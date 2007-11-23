class Compiler::MhcFinalCompiler < Compiler::CompilerBase
  def model
    @model ||= MhcFinalHorizonal.model_for_project(@project_id)
  end
  
  def locii
    @locii ||= @connection.select_values("select DISTINCT locus from mhcs order by locus")
  end
  
  def create_table
    # generate table scchema
    @connection.create_table "mhc_final_horizontals_#{@project_id}", :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      t.integer :extraction_number
      
      self.locii.each { |locus|
        t.integer "#{locus}a"
        t.integer "#{locus}b"
      }
    end
  end
  

  def compile_data
    @project.organisms.each{|organism|
      # insert in the first final mhc for each organism
      row = model.new
      
      row.organism_id = organism.id
      row.project_id = organism.project_id
      row.organism_code = organism.organism_code
      
      organism.final_mhcs.each{|mhc|
        row["#{mhc.locus}a"] ||= mhc.allele1
        row["#{mhc.locus}b"] ||= mhc.allele2
      }
      row.save
    }
  end
end
