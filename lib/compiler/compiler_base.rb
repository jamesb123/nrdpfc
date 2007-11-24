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
    @locii ||= @connection.select_values("select DISTINCT locus from #{results_table_name} order by locus").select{|l| !l.blank?}
  end
  
  def model_name
    [results_table_name.classify, final? ? "Final" : nil, "Horizontal"].compact.join("")
  end
  
  def model
    @model ||= model_name.constantize.model_for_project(@project_id)
  end
    

end