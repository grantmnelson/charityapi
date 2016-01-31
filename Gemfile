source 'https://rubygems.org'
ruby "2.3.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'figaro' #figaro for environment variables
gem 'devise'
gem 'devise-async' #for sending devise emails via sidekiq/async.
gem 'stripe'
gem 'foreman' # For developing locally. `foreman s` to start it.
gem "fog" # carrierwave + AWS S3 = heaven
gem 'carrierwave' #carrierwave makes uploading files and images much easier
gem 'sidekiq' #Background processing
# gem ?? https://github.com/bendiken/rack-throttle
gem 'smarter_csv'
#bootstrap gems
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~>3.3.6' #Twitter's Bootstrap
gem 'sass-rails', '~> 5.0'
gem 'autoprefixer-rails'

group :development, :test do
  gem "awesome_print"
  gem 'faker' #faker for making data
  gem 'simplecov', :require => false
end

group :development do
  gem 'binding_of_caller' #suggested by debugging
  gem 'better_errors' #better error debugger
  gem 'spring' #keeps app running in background, speeds up dev
  gem "letter_opener" #makes emails pop up in the browser rather than actually sending them in development mode.
  gem 'quiet_assets' # prevents logging everytime an asset's requested; cleans up server console.
end

group :production do
  gem 'unicorn', '4.8.3' #Unicorn for Heroku in production. for large amounts of traffic.
  gem 'rails_12factor' #Heroku highly recommends using this
  gem 'heroku_rails_deflate' #gzipper for Heroku, reduces pageload time and makes Google happy
  gem "rack-timeout" # kills long-running requests and logs exceptions related to timeouts. Suggested by Heroku.
  # The following are for when scaling needs to happen.
  # gem 'unicorn-worker-killer' # This allows you to kill unicorn worker_processes when they start to consume too much memory. See https://www.digitalocean.com/community/tutorials/how-to-optimize-unicorn-workers-in-a-ruby-on-rails-app for configuration instructions
end
