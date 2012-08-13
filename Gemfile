source "http://rubygems.org"

gem 'rake'
gem "sinatra", "~> 1.3.2"
gem 'sinatra-contrib'
gem "httparty", "~> 0.8.3"
gem 'slim', "~> 1.2.2"
gem 'active_attr'

group :development, :test do
  gem 'slim', "~> 1.2.2"
  gem 'pry', "~> 0.9.10"
  gem 'debugger', "~> 1.2.0"
end

group :development do
  gem 'thin'
  gem 'sinatra-reloader'
end

group :test do
  # gem 'capybara', "~> 1.1.2"
  gem "rspec", "~> 2.11.0"
  gem 'rspec-mocks'
  gem 'guard', "~> 1.3.0"
  gem 'guard-rspec', "~> 1.2.1"
  gem 'vcr', "~> 2.2.4"
  gem "webmock", "~> 1.8.8"
  gem "factory_girl_rails", "~> 4.0.0"
end