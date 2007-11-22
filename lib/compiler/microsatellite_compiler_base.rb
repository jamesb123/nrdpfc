class Compiler::MicrosatelliteCompilerBase
  
  def initialize(project_id)
    @project_id = (Project===project_id) ? project_id.id : project_id
  end
  
  def compile
    create_table
    compile_data
  end

  def locii
    @locii ||= Microsatellite.connection.select_values("select DISTINCT locus from microsatellites order by locus")
  end
  
end