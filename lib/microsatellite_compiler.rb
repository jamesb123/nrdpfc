class MicrosatelliteCompiler < MicrosatelliteCompilerBase
  def compile
    create_table
    compile_data
  end
  
  def compile_data
    # psuedo algorithm
    
    all_samples.each{|sample|
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
  
  def all_samples
    Sample.find(:all, 
      :conditions => {:project_id => @project_id},
      :order => ["organism_code"]
    )
  end
  
  def locii
    @locii ||= Microsatellite.connection.select_values("select DISTINCT locus from microsatellites order by locus")
  end
  
  def model
    @model ||= MicrosatelliteHorizontal.model_for_project(@project_id)
  end
  
  def create_table
    # generate table scchema
    ActiveRecord::Base.connection.create_table "microsatellite_horizontals_#{@project_id}", :force => true do |t|
      integer :project_id
      integer :sample_id
      integer :organism_code
      integer :org_sample
      integer :extraction_number
      
      that.locii.each { |locus|
        integer "#{locus}a"
        integer "#{locus}b"
      }
    end
    
  end
end