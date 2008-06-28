class Compiler::MicrosatelliteCompilerBase < Compiler::CompilerBase
  def locii(reload = false)
    @locii = nil if reload
    @locii ||= @connection.select_values("select DISTINCT locus from microsatellites WHERE project_id = #{@project.id.to_i} ORDER BY locus")
  end
end