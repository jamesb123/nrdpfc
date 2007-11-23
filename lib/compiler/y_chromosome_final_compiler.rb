class Compiler::YChromosomeFinalCompiler < Compiler::CompilerBase
  def model
    @model ||= YChromosomeFinalHorizontal.model_for_project(@project_id)
  end
  
  def final?
    true
  end
  
  def results_table_name
    "y_chromosomes"
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
      # insert in the first final y_chromosome for each organism
      row = model.new
      
      row.organism_id = organism.id
      row.project_id = organism.project_id
      row.organism_code = organism.organism_code
      
      organism.final_y_chromosomes.each{|y_chromosome|
        row["#{y_chromosome.locus}"] ||= y_chromosome.haplotype
      }
      row.save
    }
  end
  
  
end
