class Compiler::MtDnaFinalCompiler < Compiler::CompilerBase
  def results_table_name
    "mt_dnas"
  end
  
  def create_table
    # generate table scchema
    @connection.create_table table_name, :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      t.integer :extraction_number
      
      self.locii.each { |locus|
        t.integer "#{locus}"
      }
    end
  end
  
  def compile_data
    @project.organisms.each{|organism|
      # insert in the first final mt_dna for each organism
      row = model.new
      
      row.organism_id = organism.id
      row.project_id = organism.project_id
      row.organism_code = organism.organism_code
      
      organism.final_mt_dnas.each{|mt_dna|
        row["#{mt_dna.locus}"] ||= mt_dna.haplotype
      }
      row.save
    }
  end
  
end
