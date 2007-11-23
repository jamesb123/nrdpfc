class Compiler::MicrosatelliteCompilerBase < Compiler::CompilerBase
  def locii
    @locii ||= @connection.select_values("select DISTINCT locus from microsatellites order by locus")
  end
end