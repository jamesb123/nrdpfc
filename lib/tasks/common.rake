namespace :db do
  desc "Returns the current schema version"
  task :version => :environment do
    puts "Current version: " +
      ActiveRecord::Migrator.current_version.to_s
  end
  
  task :create => :environment do
    abcs = ActiveRecord::Base.configurations
    abcs['temp'] = abcs[RAILS_ENV].dup
    abcs['temp']['database']=""
    ActiveRecord::Base.establish_connection(:temp)
    ActiveRecord::Base.connection.create_database(abcs[RAILS_ENV]["database"])
  end

  namespace :test do
    task :create => :environment do
      abcs = ActiveRecord::Base.configurations
      abcs['temp'] = abcs['test'].dup
      abcs['temp']['database']=""
      ActiveRecord::Base.establish_connection(:temp)
      ActiveRecord::Base.connection.create_database(abcs['test']["database"])
    end
  end
end

desc "migrates, clone_structure, then annotate"
task :mca do
  Rake::Task["db:migrate"].invoke
  puts "cloning test database"
  Rake::Task["db:test:clone_structure"].invoke
  puts "annotating models"
  Rake::Task["annotate_models"].invoke
end

