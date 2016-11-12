source "https://rubygems.org"

gem "rails", "4.2.4"

# Infrastructure
gem "devise"
gem "cancancan"
gem "gorilla"
gem "mysql2"
gem "sqlite3"
gem "kaminari"
gem "paranoia", "~> 2.0"
gem "config"

# Backend Infrastructure
gem "sidekiq"
gem "sys-proctable"
gem "sendgrid"
gem "whenever", require: false
gem "pidfile"
gem "docker-api"
gem "rubyzip"

# Tracking
gem "airbrake"

# Assets
gem "haml"
gem "haml-rails"
gem "html2haml"
gem "bootstrap-sass", "~> 3.3.5"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
# gem "therubyracer", platforms: :ruby
gem "jquery-rails"

gem "turbolinks"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc # bundle exec rake doc:rails generates the API under doc/api.
gem "bcrypt", "~> 3.1.7" # Use ActiveModel has_secure_password

group :development, :test do
  gem "byebug"
end

group :test do
  gem "rspec-rails"
  gem "capybara"
  gem "chromedriver-helper"
  gem "factory_girl_rails"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem "spring"
  gem "capistrano-rails"
  gem "rubocop"
end
