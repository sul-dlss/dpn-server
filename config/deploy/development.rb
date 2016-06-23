server 'dpn-dev.stanford.edu', user: 'dpn', roles: %w(app db web)

Capistrano::OneTimeKey.generate_one_time_key!

# Use a 'development' environment on dpn-dev, and our fork of the dpn-server
# project must modify the config/environment/development.rb file so that all the application settings
# are pulled in from our private shared_configs, where the secrets.yml data
# specifies how our node is configured.  To do this, we need some of the code
# from the config/environment/production.rb file.  For details, see:
# https://github.com/sul-dlss/shared_configs/blob/dpn-dev-server
set :rails_env, 'development'
set :bundle_without, 'test'

set :delayed_job_workers, 4
