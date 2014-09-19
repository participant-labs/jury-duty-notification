source 'https://rubygems.org'

ruby '2.1.2'

# Server
gem 'rails', '4.1.4'
gem 'pg'
#gem 'unicorn-rails'
gem 'thin'

# Rack
gem 'rack-timeout'
gem 'rack-canonical-host'

# Models
gem 'foreigner'

# Views
gem 'slim'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'

# Assets
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# scraping
gem 'nokogiri'

# notfications
gem 'twilio-ruby'
gem 'e164' # a phone number standard format used by twilio

gem 'resque'
gem 'resque-heroku'
gem 'redis'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
group :doc do
  gem 'sdoc', '~> 0.4.0'
end

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
group :development do
  gem 'spring'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'byebug', require: false
end

group :test do
  gem 'faker'
end

group :production do
  gem 'rails_12factor'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

