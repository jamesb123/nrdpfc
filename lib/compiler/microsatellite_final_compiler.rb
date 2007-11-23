class Compiler::MicrosatelliteFinalCompiler < Compiler::MicrosatelliteCompilerBase
  
  def compile_data
    # psuedo algorithm
    
    all_organisms.each{|organism|
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
  
  def all_organisms
    Organism.find(:all, 
      :conditions => {:project_id => @project_id},
      :order => "organism_code"
    )
  end
  
  def model
    @model ||= MicrosatelliteFinalHorizontal.model_for_project(@project_id)
  end
  
  def create_table
    # generate table scchema
    ActiveRecord::Base.connection.create_table "microsatellite_final_horizontals_#{@project_id}", :force => true do |t|
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
end