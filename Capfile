load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

# add the 'db' directory to shared_children so that our database is preserved between releases
shared_children.push('db')

# customized tasks
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "[internal] set ownership for deployment directory"
  task :set_owner, :except => { :no_release => true } do
    run "#{try_sudo} chown -R www-data:www-data #{deploy_to}"
  end
  
  desc "[internal] creates symlink to shared db file for current release"
  task :symlink_db, :except => { :no_release => true } do
    run <<-CMD
      rm -f #{latest_release}/db/#{rails_env}.sqlite3 &&
      ln -s #{shared_path}/db/#{rails_env}.sqlite3 #{latest_release}/db/#{rails_env}.sqlite3
    CMD
  end
  
  desc "[internal] touch log and db files to ensure they exist and have proper permissions"
  task :touch_files, :except => { :no_release => true } do
    run <<-CMD
      touch #{shared_path}/log/#{rails_env}.log &&
      chmod g+w #{shared_path}/log/#{rails_env}.log &&
      touch #{shared_path}/db/#{rails_env}.sqlite3 &&
      chmod g+w #{shared_path}/db/#{rails_env}.sqlite3
    CMD
  end
  
  namespace :web do
    desc "Restarts Apache web server"
    task :restart do
      run "#{try_sudo} /etc/init.d/apache2 restart"
    end
    
    desc "Updates and reloads apache configuration for application"
    task :update_config do
      run <<-CMD
        #{try_sudo} cp #{current_release}/config/apache.conf /etc/apache2/sites-available/rails_apps &&
        #{try_sudo} /etc/init.d/apache2 reload
      CMD
    end
  end
  
  namespace :rollback do
    desc <<-DESC
      [internal] Removes the most recently deployed release.
      This is called by the rollback sequence, and should rarely
      (if ever) need to be called directly.
    DESC
    task :cleanup, :except => { :no_release => true } do
      run "if [ `readlink #{current_path}` != #{current_release} ]; then #{try_sudo} rm -rf #{current_release}; fi"
    end
  end
  
  after "deploy:setup", "deploy:set_owner"
  after "deploy:setup", "deploy:touch_files"
  after "deploy:update", "deploy:set_owner"
  after "deploy:upload", "deploy:set_owner"
  before "deploy:finalize_update", "deploy:symlink_db"
end
