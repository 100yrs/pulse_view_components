# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
# require 'active_job/railtie'
# require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
# require 'action_mailer/railtie'
# require 'action_mailbox/engine'
# require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

require 'view_component'
require 'pulse/view_components'
require 'pulse/view_components/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  # Demo Application
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    # config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Store uploaded files on the local file system in a temporary directory.
    # config.active_storage.service = :test

    # Don't generate system test files.
    config.generators.system_tests = nil

    # ViewComponent
    config.view_component.generate.preview = true
    config.view_component.preview_controller = 'PreviewController'
    config.view_component.previews.paths << Rails.root.join('../previews')
    config.view_component.instrumentation_enabled = true
    config.view_component.use_deprecated_instrumentation_name = false

    # Lookbook
    config.lookbook.project_name =
      "Pulse ViewComponents v#{Pulse::ViewComponents::VERSION::STRING}"
    config.lookbook.ui_theme = 'zinc'

    # Add preview paths to autoload so they work with eager_load = true
    config.autoload_paths << Rails.root.join('../previews')
  end
end
