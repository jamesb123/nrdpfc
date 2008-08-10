set :application, "nrdpfc"

set :scm, :git
set :repository,    'git@nrdpfc.info:nrdpfc.git'
set :deploy_via, :remote_cache
set :git_enable_submodules, true

set :keep_releases, 5
set :use_sudo, false

ssh_options[:paranoid] = false
default_run_options[:pty] = true

task :production do
  set :deploy_to, "/var/www/nrdpfc/"
  set :rails_env,      "production"
  
  role :app, "nrdpfc@nrdpfc.info"
  role :web, "nrdpfc@nrdpfc.info"
  role :db,  "nrdpfc@nrdpfc.info", :primary => true
end

task :staging do
  set :deploy_to, "/var/www/nrdpfc_staging/"
  set :rails_env,      "staging"
  
  role :app, "nrdpfc@nrdpfc.info"
  role :web, "nrdpfc@nrdpfc.info"
  role :db,  "nrdpfc@nrdpfc.info", :primary => true
end

# =============================================================================
# TASKS
# Don't change unless you know what you are doing!
after "deploy:update_code", "deploy:symlink_database_yml"
after "deploy:update_code", "deploy:set_default_rails_env"

namespace :deploy do
  task :symlink_database_yml do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  
  task :set_default_rails_env do
    run "echo #{rails_env} > #{release_path}/config/RAILS_ENV"
  end
  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end