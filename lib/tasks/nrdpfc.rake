task :compile_data => :environment do 
  Project.find(:all).each{|project|
    puts "Compiling VIEW B for #{project.to_label}"
    MicrosatelliteCompiler.new(project).compile
    puts "Compiling VIEW C for #{project.to_label}"
    MicrosatelliteOrganismCompiler.new(project).compile
  }
end