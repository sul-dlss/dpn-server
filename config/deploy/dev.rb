server 'dpn-dev.stanford.edu', user: 'dpn', roles: %w(app db web)

Capistrano::OneTimeKey.generate_one_time_key!

# dpn-dev is a "demo" system for the DPN node network; although it is named
# with the `-dev` suffix, it's run like a `-stage` system with a
# RAILS_ENV=production
set :rails_env, 'production'
