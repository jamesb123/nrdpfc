class Compiler
  def self.compile_project(project, verbose = false)
    puts "Compiling VIEW B for #{project.to_label}" if verbose
    Compiler::MicrosatelliteCompiler.new(project).compile
    puts "Compiling VIEW C for #{project.to_label}" if verbose
    Compiler::MicrosatelliteFinalCompiler.new(project).compile
    
    puts "YChromosomeFinalCompiler for #{project.to_label}" if verbose
    Compiler::YChromosomeFinalCompiler.new(project).compile
    puts "MtDnaFinalCompiler for #{project.to_label}" if verbose
    Compiler::MtDnaFinalCompiler.new(project).compile
    puts "MhcFinalCompiler for #{project.to_label}" if verbose
    Compiler::MhcFinalCompiler.new(project).compile
    
    project.recompile_required = false
    project.save(false)
    
    true
  end
end

Dir[File.join(File.dirname(__FILE__), "compiler/**/*.rb")].each{|file| require file}