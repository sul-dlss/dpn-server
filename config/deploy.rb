# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'dpn-server'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/opt/app/dpn/dpn-server'

set :scm, :git
set :git_strategy, Capistrano::Git::SubmoduleStrategy
set :repo_url, 'https://github.com/sul-dlss/dpn-server.git'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w(
  config/database.yml
  config/dpn.yml
  config/resque.yml
  config/resque-pool.yml
  config/secrets.yml
  config/honeybadger.yml
)

# Default value for linked_dirs is []
set :linked_dirs, %w(
  log
  public/system
  public/uploads
  tmp/cache
  tmp/pids
  tmp/sockets
  vendor/bundle
)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

set :honeybadger_env, fetch(:stage)
