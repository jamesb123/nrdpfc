class Compiler::GenderFinalCompiler < Compiler::CompilerBase
  def model
    @model ||= GenderFinalHorizontal.model_for_project(@project_id)
  end
  
  def final?
    true
  end
  
  def results_table_name
    "genders"
  end
  
  def create_table
    # generate table scchema
    @connection.create_table table_name, :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      
      self.locii.each { |locus|
        t.column "#{locus}", *column_args(Gender, "gender")
      }
    end
  end
  

  def compile_data
    @project.organisms.each{|organism|
      # insert in the first final gender for each organism
      row = model.new
      
      row.organism_id = organism.id
      row.project_id = organism.project_id
      row.organism_code = organism.organism_code
      
      organism.final_genders.each{|gender|
        row["#{gender.locus}"] ||= gender.gender
      }
      row.save
    }
  end
  
  
end
