class Compiler::CompilerBase
  
  def initialize(project)
    @project = project.is_a?(Project) ? project : Project.find(project)
    @project_id = @project.id
    @connection = ActiveRecord::Base.connection
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
  
end