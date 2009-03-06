load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

# add the 'db' directory to shared_children so that our database is preserved between releases
shared_children.push('db')

# customized tasks
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "[internal] set ownership for deployment directory"
  task :set_owner, :except => { :no_release => true } do
    run "#{try_sudo} chown -R www-data:www-data #{deploy_to}"
  end
  
  desc "[internal] fix db directory and logs, including ownership"
  task :fix_db_and_logs, :except => { :no_release => true } do
    symlink_db
    touch_files
  end
  
  desc "[internal] creates symlink to shared db file for current release"
  task :symlink_db, :except => { :no_release => true } do
    run <<-CMD
      rm -f #{latest_release}/db/production.sqlite3 &&
      ln -s #{shared_path}/db/production.sqlite3 #{latest_release}/db/production.sqlite3
    CMD
  end
  
  desc "[internal] touch log and db files to ensure they exist and have proper permissions"
  task :touch_files, :except => { :no_release => true } do
    run <<-CMD
      touch #{shared_path}/log/production.log &&
      chmod g+w #{shared_path}/log/production.log &&
      touch #{shared_path}/db/production.sqlite3 &&
      chmod g+w #{shared_path}/db/production.sqlite3
    CMD
  end
  
  after "deploy:setup", "deploy:set_owner"
  after "deploy:update", "deploy:set_owner"
  after "deploy:upload", "deploy:set_owner"
  before "deploy:finalize_update", "deploy:fix_db_and_logs"
end