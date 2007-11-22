class Compiler
  def self.compile_project(project, verbose = false)
    puts "Compiling VIEW B for #{project.to_label}" if verbose
    Compiler::MicrosatelliteCompiler.new(project).compile
    puts "Compiling VIEW C for #{project.to_label}" if verbose
    Compiler::MicrosatelliteOrganismCompiler.new(project).compile
    
    project.recompile_required = false
    project.save(false)
    
    true
  end
end

Dir[File.join(File.dirname(__FILE__), "compiler/**/*.rb")].each{|file| require file}