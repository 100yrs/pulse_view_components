# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in pulse_view_components.gemspec
gemspec

gem 'rake', '~> 13.3.1'

gem 'rails', '~> 8.1.2'
# Use Puma as the app server
gem 'puma', '~> 7.1.0'
gem 'stimulus-rails'
gem 'turbo-rails'

gem 'active_link_to'
gem 'lookbook', '~> 2.3.14'
gem 'slim-rails'
gem 'view_component', '~> 4.2.0'

gem 'kramdown', '~> 2.5.1'
gem 'sourcemap', '~> 0.1.1'

gem 'foreman'

group :development, :test do
  gem 'bootsnap'
  # sprockets replacement
  gem 'propshaft'
end

# development dependencies
group :development do
  gem 'sqlite3'

  # gem 'capybara', '~> 3.40.0'
  gem 'listen', '~> 3.9.0'
  gem 'matrix', '~> 0.4.3'
  gem 'mocha'
  gem 'pry'
  gem 'rubocop'
  gem 'rubocop-capybara', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
  # gem 'rubocop-rails-accessibility', '~> 1.0.1'

  # Bundle and process CSS [https://github.com/rails/cssbundling-rails]
  gem 'cssbundling-rails'

  # Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
  gem 'jsbundling-rails'

  # gem 'thor'
  # gem 'yard', '~> 0.9.38'
end

group :test do
  gem 'capybara'
  gem 'inline_svg'
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'webmock'
end
