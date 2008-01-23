set :application, "nrdpfc"
set :repository, "https://svn.nrdpfc.info/repos/nrdpfc/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/nrdpfc/"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "nrdpfc@nrdpfc.info"
role :web, "nrdpfc@nrdpfc.info"
role :db, "nrdpfc@nrdpfc.info", :primary => true

set :use_sudo, false


desc "Symlink the tmp directory, to keep sessions the same"
task :maintain_sessions, :roles => [:app] do
  run <<-EOF
    rm -rf "#{release_path}/tmp/" &&
    mkdir -p #{shared_path}/tmp/{cache,pids,sessions,sockets} &&
    ln -s #{shared_path}/tmp #{release_path}/tmp
  EOF
end

task :make_public_not_public_writeable do
  run "chmod 755 #{release_path}/public #{release_path}/public/dispatch.fcgi"
end 

task :create_public_file_links do
  for dir in %w()
    run "mkdir #{shared_path}/#{dir} -p && rm -rf #{release_path}/public/#{dir} && ln -nfs #{shared_path}/#{dir} #{release_path}/public/#{dir}"
  end
end

task :after_update_code, :roles => [:app] do
  maintain_sessions
#  create_public_file_links
  make_public_not_public_writeable
end