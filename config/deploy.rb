# config valid only for current version of Capistrano
# lock "3.7.2"
lock "3.11.0"

server '46.101.17.87', roles: [:web, :app, :db], primary: true

#set :repo_url, "git@github.com:spencermeyer/Ruby_Webscraping.git"
set :repo_url, "git@github.com:spencermeyer/Ruby_Webscraping.git"

set :application, "Rubyscrape"
set :user, 'deploy'
#set :user, 'root'

set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 2

namespace :config do
  desc "Symlink application config files."
  task :symlink do
    on roles(:app) do
      execute "ln -sf {#{shared_path},#{release_path}}/config/secrets.yml"
    end
  end
end
after "deploy", "config:symlink"

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      #unless `git rev-parse HEAD` == `git rev-parse origin/master`
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        #puts "WARNING: HEAD is not the same as origin/master"
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'Stop Puma'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:stop'
    end
  end

  desc 'Start a worker'
  task :start_a_resque_worker do
    on roles :app do
      #execute "cd #{deploy_to}/current/; echo 'resque cap ran 2' > BLAH.md"
      # execute "cd #{deploy_to}/current/; RAILS_ENV=production BACKGROUND=yes QUEUE=* bundle exec rake environment resque:work"

      #  RAILS_ENV=production BACKGROUND=yes QUEUE=* bundle exec rake environment resque:work ##WORKS COMMAND LINE
      #  execute "cd #{deploy_to}/current/ && RAILS_ENV=#{fetch(:stage)} BACKGROUND=yes QUEUE=* /home/deploy/.rvm/gems/ruby-2.4.0/bin/bundle exec rake resque:work"
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
  after  :finishing,    :start_a_resque_worker
end

  # ps aux | grep puma    # Get puma pid
  # kill -s SIGUSR2 pid   # Restart puma
  # kill -s SIGTERM pid   # Stop puma

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
