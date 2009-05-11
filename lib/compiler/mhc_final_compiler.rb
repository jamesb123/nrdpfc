class Compiler::MhcFinalCompiler < Compiler::CompilerBase
  def final?
    true
  end
  
  def results_table_name
    "mhcs"
  end

  def create_table
    # generate table scchema
    @connection.create_table table_name, :force => true do |t|
      t.integer :project_id
      t.integer :organism_id
      t.string :organism_code, :limit => 128
      
      self.locii.each { |locus|
        t.column "#{locus}a", *column_args(Mhc, "allele1")
        t.column "#{locus}b", *column_args(Mhc, "allele2")
      }
    end
    @connection.add_index table_name, 'organism_id'
  end
 
  def final_mhcs_query
    @final_mhcs_query ||= QueryBuilder.new(
      :parent => :mhcs, 
      :tables => ["mhcs", "organisms"], 
      :fields => {:mhcs => ["locus", "allele1", "allele2"]}, 
      :filterings => [
        ["mhcs", "finalResult", "=", true],
        ["organisms", "project_id", "=", @project.id],
        ["organisms", "id", "=", "%s"]
      ]).to_sql
  end

  def compile_organism(row)
    each(final_mhcs_query % row["organism_id"]) do |mhc|
      row["#{mhc["mhcs_locus"]}b"] ||= mhc["mhcs_allele1"]
      row["#{mhc["mhcs_locus"]}a"] ||= mhc["mhcs_allele2"]
    end
  end
end
