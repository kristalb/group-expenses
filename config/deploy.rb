set :stages, %w(staging production)
set :default_stage, "production"
require 'capistrano/ext/multistage'
set :rails_env, "production"

set :application, "house"
set :repository, "git@nodoka:house.git"
set :branch, "master"
set :deploy_to, "/var/www/rails/#{application}/#{rails_env}"
set :deploy_via, :copy

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

server "nodoka", :app, :web, :db, :primary => true
