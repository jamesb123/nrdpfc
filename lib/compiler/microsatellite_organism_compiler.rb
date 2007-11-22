class Compiler::MicrosatelliteOrganismCompiler < Compiler::MicrosatelliteCompilerBase
  
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
    @model ||= MicrosatelliteOrganismHorizontal.model_for_project(@project_id)
  end
  
  def create_table
    # generate table scchema
    ActiveRecord::Base.connection.create_table "microsatellite_organism_horizontals_#{@project_id}", :force => true do |t|
      integer :project_id
      integer :organism_id
      string :organism_code, :limit => 128
      integer :extraction_number
      
      that.locii.each { |locus|
        integer "#{locus}a"
        integer "#{locus}b"
      }
    end
    
  end
end