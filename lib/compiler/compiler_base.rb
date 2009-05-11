class Compiler::CompilerBase
  
  def initialize(project)
    @project = project.is_a?(Project) ? project : Project.find(project)
    @project_id = @project.id
    @connection = ActiveRecord::Base.connection
  end
  
  def final?
    raise "Implement me"
  end
  
  def compile
    create_table
    compile_data
  end
  
  def column_args(model, field_name)
    col = model.columns_hash[field_name.to_s]
    [col.type, {:limit => col.limit}]
  end

  def create_table
    raise "Implement me"
  end
  
  def compile_data
    raise "Implement me"
  end
  
  def results_table_name
    raise "Implement me"
  end
    
  def table_name
    "#{results_table_name.singularize}_#{final? ? 'final_' : ''}horizontals_#{@project_id}"
  end

  def locii
    @locii ||= @connection.select_values("select DISTINCT locus from #{results_table_name} order by locus").select do |l|
      if l.blank?
        Compiler.logger.warn("Warning: blank 'locus' found in #{results_table_name} (#{self.class}).  This will cause compiler issues.")
        next false
      end
      true
    end
  end
  
  def model_name
    [results_table_name.classify, final? ? "Final" : nil, "Horizontal"].compact.join("")
  end
  
  def model
    @model ||= model_name.constantize.model_for_project(@project_id)
  end
  
  def self.organism_query(project)
    QueryBuilder.new(
      :parent => :organism, 
      :fields => {:organisms => ["id", "project_id", "organism_code"]},
      :filterings => [
        ["organisms", "project_id", "=", project.id]
      ]
    )
  end

  def create_row_for_organism(organism)
    # insert in the first final mt_dna for each organism
    row = {}
    
    row["organism_id"] = organism["organisms_id"]
    row["project_id"] = organism["organisms_project_id"]
    row["organism_code"] = organism["organisms_organism_code"]

    compile_organism(row)

    model.insert(row)
  end

  def each(sql)
    @connection.select_all( sql ).each do |obj|
      yield obj
    end
  end


end
