source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'rails', '~> 7.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'devise'
gem 'devise_invitable', '~> 2.0.0'
gem 'sentry-ruby'
gem 'sentry-rails'
gem 'sprockets-rails'
gem 'cssbundling-rails'
gem 'jsbundling-rails'
gem 'turbo-rails'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'pry-byebug'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara-email'
  gem 'rspec-github', require: false
  gem 'timecop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
