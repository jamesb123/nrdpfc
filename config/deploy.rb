set :application, "nrdpfc"
set :repository, "https://svn.nrdpfc.info/repos/nrdpfc/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :deploy_via, :remote_cache


set :use_sudo, false

task :production do
  set :deploy_to, "/var/www/nrdpfc/"
  set :rails_env,      "production"
  
  role :app, "nrdpfc@nrdpfc.info"
  role :web, "nrdpfc@nrdpfc.info"
  role :db,  "nrdpfc@nrdpfc.info", :primary => true
end

task :development do
  set :deploy_to, "/var/www/nrdpfc_dev/"
  set :rails_env,      "development"
  
  role :app, "nrdpfc@nrdpfc.info"
  role :web, "nrdpfc@nrdpfc.info"
  role :db,  "nrdpfc@nrdpfc.info", :primary => true
end

# =============================================================================
# TASKS
# Don't change unless you know what you are doing!
after "deploy:update_code", "deploy:symlink_database_yml"

namespace :deploy do
  task :symlink_database_yml do
    run "ln -nfs {#{shared_path},#{release_path}/config}/database.yml"
  end
  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end