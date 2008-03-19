namespace :db do
  task :nuke => :environment do
    abcs = ActiveRecord::Base.configurations
    ["development"].each do |db|
      case abcs[db]["adapter"]
        when "mysql"
          ActiveRecord::Base.establish_connection(db.to_sym)
          conn = ActiveRecord::Base.connection
          conn.execute("DROP DATABASE #{abcs[db]["database"]}")
          conn.execute("CREATE DATABASE #{abcs[db]["database"]}")
          ActiveRecord::Base.establish_connection(db.to_sym)
        when "sqlite", "sqlite3"
          dbfile = abcs[db]["database"] || abcs[db]["dbfile"]
          File.delete(dbfile) if File.exist?(dbfile)
          ActiveRecord::Base.establish_connection(db.to_sym)
        else
          raise "Task not supported by '#{abcs[db]["adapter"]}'"
      end
      ENV['RAILS_ENV'] = db
      Rake::Task["db:migrate"].dup.invoke
      #Rake::Task["db:fixtures:load"].dup.invoke
      #Rake::Task["db:test:clone_structure"].dup.invoke
      #Rake::Task["annotate_models"].dup.invoke
      `railroad -o doc/models.dot -M`
    end
  end
end
