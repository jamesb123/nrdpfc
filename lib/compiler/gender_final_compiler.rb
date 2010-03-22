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
    @connection.add_index table_name, 'organism_id'
  end
  

  def final_genders_query
    @final_genders_query ||= QueryBuilder.new(
      :parent => :genders, 
      :tables => ["genders", "organisms"], 
      :fields => {:genders => ["locu_id", "gender"]}, 
      :filterings => [
        ["genders", "finalResult", "=", true],
        ["organisms", "project_id", "=", @project.id],
        ["organisms", "id", "=", "%s"]
      ]).to_sql
  end
    
  def compile_organism(row)
    each(final_genders_query % row[:organism_id]) do |gender|
      locu = locu_col_name(gender["genders_locu_id"])
      row[locu] ||= gender["genders_gender"]
    end
  end
  
end
