# add config/deploy to load_path
$: << File.expand_path('../deploy/', __FILE__)

require 'bundler/capistrano'
require 'capistrano_database'

#set :whenever_command, 'bundle exec whenever'
#require 'whenever/capistrano'

# do not cache
#set :deploy_via, :remote_cache

set :application, "website"
#set :repository,  ENV['REPO'] || "gitosis@192.168.0.222:store.git"
set :repository,  ENV['REPO'] || File.expand_path('../../.git/', __FILE__)

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_server, ENV['DEPLOY_SERVER'] || 'localhost'
set :user, ENV['DEPLOY_USER'] || ENV['USER'] || "rails"
set :use_sudo, true
default_run_options[:pty] = true

role :web, "#{deploy_server}"                          # Your HTTP server, Apache/etc
role :app, "#{deploy_server}"                          # This may be the same as your `Web` server
role :db,  "#{deploy_server}", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# skip touching files in public/[images javascripts stylesheets] since we store files in assets
set :normalize_asset_timestamps, false

set :maintenance_template_path, File.expand_path('../deploy/maintenance.rhtml', __FILE__)

# == https://rvm.beginrescueend.com/integration/capistrano/
#
# Using RVM rubies with Capistrano
#
# * You currently have three options:
#
# * If your rvm version on the server and locally are recent enough, use the new built in integration.
# Enable .ssh environment variables using the PermitUserEnvironment option in your ssh configuration file
#
# * Use the capistrano :default_environment setting
#
# 3. use default_environment

# set :rvm_ruby_string, "ruby-1.9.2-p180"
#set :rbenv_version, "1.9.2-p290"
#set :rbenv_version, ENV['DEPLOY_RBENV_VERSION'] || "jruby-1.6.7.2"
set :rbenv_version, ENV['RBENV_VERSION'] || "1.9.3-p194"

set :default_environment, {
  'PATH' => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH",
  'RBENV_VERSION' => "#{rbenv_version}",
}

# bundle install every deployment to avoid platform difference
# with --deployment will use Gemfile.lock in app server
set :bundle_flags, ""

#set :rake_binary, "/home/#{user}/.rbenv/shims/rake"
set :rake_binary, "rake"
#set :rake, "RBENV_VERSION=1.9.2-p290 #{rake_binary}"

# kirk settting
#set :kirk_binary, "/home/#{user}/.rbenv/shims/kirk"
#set :kirk_conf, "#{current_path}/config/kirk.rb"

before "db:setup", "deploy:chown"
#after "deploy:update", "deploy:compile"
after 'deploy:update', 'carrierwave:symlink'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  # task :start do ; end
  # task :stop do ; end
  # task :restart, :roles => :app, :except => { :no_release => true } do
  #   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  # end

  #%w(start stop restart).each do |action|
    #desc "kirk:#{action}"
    #task action.to_sym do
       #find_and_execute_task("kirk:#{action}")
    #end
  #end

  %w(start stop restart).each do |action|
    desc "thin:#{action}"
    task action.to_sym do
      run "cd #{current_path} && bundle exec thin #{action} -C #{current_path}/config/thin.yml"
    end
  end

  # jruby cannot compile assets
  namespace :assets do
    desc "deploy the precompiled assets"
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run_locally("rake assets:clean assets:precompile RAILS_ENV=#{rails_env} #{asset_env}")
      top.upload("public/assets", "#{release_path}/public/", :via => :scp, :recursive => true)
      run_locally("rm -rf public/assets")
    end
  end

  #desc "compile ruby files to java class files"
  #task :compile, :roles => :app, :except => { :no_release => true } do
    #run "cd #{current_path} && sh -c './script/rubyc app config/initializers'"
  #end

  task :chown, :roles => :app do
    run "#{try_sudo} chown -R #{user}:#{user} #{deploy_to}"
  end

  desc "create db:seed"
  task :seed, :roles => :app do
    run "cd #{current_path} && rake db:seed RAILS_ENV=#{rails_env}"
  end
end

namespace :carrierwave do
  desc "Symlink the Rack::Cache files"
  task :symlink, :roles => [:app] do
    run "mkdir -p #{shared_path}/uploads && ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
end

#namespace :unicorn do
  #desc "start unicorn"
  #task :start, :roles => :app, :except => { :no_release => true } do
    #run "/etc/init.d/unicorn start"
  #end

  #desc "stop unicorn"
  #task :stop, :roles => :app, :except => { :no_release => true } do
    #run "/etc/init.d/unicorn stop"
  #end

  #desc "reload unicorn"
  #task :reload, :roles => :app, :except => { :no_release => true } do
    #run "/etc/init.d/unicorn reload"
  #end

  #desc "restart unicorn"
  #task :restart, :roles => :app, :except => { :no_release => true } do
    #run "/etc/init.d/unicorn restart"
  #end

  ## inherit default environment used for sudo
  #def env_var
    #default_environment.map do |k,v|
      #"#{k}=#{v}"
    #end.join(" ")
  #end
#end

#namespace :kirk do
  #desc "start kirk"
  #task :start, :roles => :app, :except => { :no_release => true } do
    #run "#{try_sudo} service kirk start"
  #end

  #desc "stop kirk"
  #task :stop, :roles => :app, :except => { :no_release => true } do
    #run "#{try_sudo} service kirk stop"
  #end

  #desc "reload kirk"
  #task :reload, :roles => :app, :except => { :no_release => true } do
    #run "touch #{current_path}/REVISION"
  #end

  #desc "restart kirk"
  #task :restart, :roles => :app, :except => { :no_release => true } do
    ##run "#{try_sudo} service kirk restart"
    #run "env #{env_var}  #{kirk_binary} redeploy -R #{current_path}/config.ru"
  #end

  ## inherit default environment used for sudo
  #def env_var
    #default_environment.map do |k,v|
      #"#{k}=#{v}"
    #end.join(" ")
  #end
#end

namespace :log do
  desc "Tail the Rails log..."
  task :tail, :roles => :app do
    run "tail -f #{current_path}/log/production.log" do |channel, stream, data|
      puts  # for an extra line break before the host name
      puts "#{channel[:server]} -> #{data}"
      break if stream == :err
    end
  end
end
