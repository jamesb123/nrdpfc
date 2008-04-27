class Compiler
  def self.logger(output = nil)
    @logger ||= Logger.new(output || "#{RAILS_ROOT}/log/compile_warnings.log")
  end
  
  def self.compile_project(project, verbose = false)
    logger.info("Compiling VIEW B for #{project.to_label}")
    Compiler::MicrosatelliteCompiler.new(project).compile
    logger.info("Compiling VIEW C for #{project.to_label}")
    Compiler::MicrosatelliteFinalCompiler.new(project).compile
    
    logger.info("YChromosomeFinalCompiler for #{project.to_label}")
    Compiler::YChromosomeFinalCompiler.new(project).compile
    logger.info("MtDnaFinalCompiler for #{project.to_label}")
    Compiler::MtDnaFinalCompiler.new(project).compile
    logger.info("MhcFinalCompiler for #{project.to_label}")
    Compiler::MhcFinalCompiler.new(project).compile
    logger.info("GenderFinalCompiler for #{project.to_label}")
    Compiler::GenderFinalCompiler.new(project).compile
    
    project.recompile_required = false
    project.save(false)
    
    true
  end
end

Dir[File.join(File.dirname(__FILE__), "compiler/**/*.rb")].each{|file| require file}