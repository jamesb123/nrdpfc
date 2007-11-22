task :compile_data => :environment do 
  Project.find(:all).each{|project|
    Compiler.compile_project(project)
  }
end