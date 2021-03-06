source 'https://rubygems.org'
ruby '2.4.0'

gem 'mechanize'
gem 'pkg-config'   # might help nokogiri install.
gem 'nokogiri', '~>1.10.4' # mechanize was resolved to 2.7.5, which depends on nokogiri (= 1.8.1)
gem 'rails', '~> 5.1.0'
gem 'pg' #  Heroku really wants pg not mysql :(
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# gem 'libv8', '~> 4.5', '>= 4.5.95.5'  # this the latest.
# gem 'therubyracer', '~> 0.12.3'
gem 'devise', '~> 4.7.1'
gem 'useragent'
gem 'newrelic_rpm'
gem 'resque'
gem 'resque-web'
# gem 'resque-status'  # adds methods to get status
gem 'resque-scheduler-web'
gem 'resque-scheduler', '~> 4.3.1'
gem 'resque-delayed', '~> 1.3.0'
gem 'will_paginate'
gem 'mailgun-ruby', '~> 1.1.10'
gem 'httparty'
gem 'rest-client'
gem 'slack-notifier'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'listen', '~> 3.0.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'pry-byebug'  # changed from pry.
  gem 'annotate'
  gem 'vcr'
  gem 'webmock'
  gem 'factory_girl_rails'
  gem 'awesome_print'
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rspec-rails'
  gem 'capistrano', '~> 3.11.0',        require: false
  gem 'capistrano-rvm',                 require: false
  gem 'capistrano-rails',               require: false
  gem 'capistrano-bundler',             require: false
  gem 'capistrano3-puma',               require: false  
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
