source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Rails REST API documentation tool
gem 'apipie-rails', '~> 0.5.10'

# Authentication solution for Rails based on JWT
gem 'knock', '~> 2.1', '>= 2.1.1'

# Easiest way to manage multi-environment settings
gem 'config', '~> 1.7'

# Mongoid is an ODM Framework for MongoDB
gem 'mongoid', '~> 7.0', '>= 7.0.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
