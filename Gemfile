# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in pulse_view_components.gemspec
gemspec

gem "rake", "~> 13.1"

gem "rails", "~> 7.0.8"
# Use Puma as the app server
gem "puma", "~> 6.4.2"
gem "turbo-rails"
gem "stimulus-rails"

gem "lookbook", "~> 2.2.1"
gem 'slim-rails'
gem "view_component"

gem "kramdown", "~> 2.4"
gem "sourcemap", "~> 0.1"

gem "foreman"

group :test do
  gem "webmock"
end

# development dependencies
group :development do
  gem "sqlite3"

  gem "capybara", "~> 3.39.2"
  gem "listen", "~> 3.9"
  gem "matrix", "~> 0.4.2"
  gem "mocha"
  gem "pry"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  # gem "rubocop-rails-accessibility", "~> 0.2.0"
  gem "simplecov", "~> 0.22.0"
  gem "dartsass-rails"

  gem 'cssbundling-rails'

  # Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
  gem 'jsbundling-rails'

  # gem "thor"
  # gem "yard", "~> 0.9.35"
end