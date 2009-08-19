class Compiler::CompilerBase
  
  def initialize(project)
    @project = project.is_a?(Project) ? project : Project.find(project)
    @project_id = @project.id
    @connection = ActiveRecord::Base.connection
  end
  
  def final?
    raise "Implement me"
  end

  def data_exists?
    res = ActiveRecord::Base.connection.select_values('select count(*) as c from mhcs where project_id = 11')
    res[0].to_i > 0
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
  
  # This is VERY slow to run individually on each compiler.
  # Please use Compiler.compile_project
  def compile_data
    # See lib/compiler.rb Compiler.compile_project, it
    # operates on the compilers in aggregate. Those compilers
    # don't use #compile nor #compile_data and the code
    # needs to stay in sync.
    @project.compile_each_organism do |org|
      self.create_row_for_organism(org)
    end
  end
  
  def results_table_name
    raise "Implement me"
  end
    
  def table_name
    "#{results_table_name.singularize}_#{final? ? 'final_' : ''}horizontals_#{@project_id}"
  end

  def locii
    @locii ||= begin
      ids = unique_locu_ids.select {|l| !l.blank? }
      list = if ids.size >   0
        Locu.find(unique_locu_ids, :select => 'locus').map(&:locus) 
       else
         []
       end
      list << 'Unknown' if unmatched_locii?
      list
    end
  end

  def unmatched_locii?
    if unique_locu_ids.any? {|l| l.blank? }
      true
    else
      unique_locu_ids.any? do |l|
        Locu.find(l).nil?
      end
    end
  end

  def unique_locu_ids
    @connection.select_values("select DISTINCT locu_id from #{results_table_name} where project_id = #{@project.id}")
  end

  def locu_col_name(id)
    locu = id.nil? ? nil : Locu.find(id) rescue nil
    locu.nil? ? 'Unknown' : locu.locus
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
