class Compiler
  def self.logger(output = nil)
    @logger ||= Logger.new(output || "#{RAILS_ROOT}/log/compile_warnings.log")
  end
  
  def self.compile_project(project, verbose = false)
    logger.info("Compiling VIEW B for #{project.to_label}")
    # This compiler works on each sample instead of organism
    Compiler::MicrosatelliteCompiler.new(project).compile
    
    compilers = [
      Compiler::YChromosomeFinalCompiler.new(project),
      Compiler::MtDnaFinalCompiler.new(project),
      Compiler::MhcFinalCompiler.new(project),
      Compiler::GenderFinalCompiler.new(project),
      Compiler::MicrosatelliteFinalCompiler.new(project)
    ]

    # We need the tables even if we don't put data in them
    compilers.each {|c| c.create_table }

    compilers.delete_if do |comp|
      !comp.data_exists?
    end

    # Iterating over each organism is very time consuming,
    # so we do it once and compile all the results for each
    # organism at the same time
    project.compile_each_organism do |org|
      compilers.each do |c|
        c.create_row_for_organism(org)
      end
    end

    Compiler::CompilerBase.clear_loci_cache
    
    project.recompile_required = false
    project.save(false)
    
    true
  end
end

Dir[File.join(File.dirname(__FILE__), "compiler/**/*.rb")].each{|file| require file}
