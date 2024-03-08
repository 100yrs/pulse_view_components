require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f

    # For compatibility with applications that use this config
    config.action_controller.include_all_helpers = false

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Store uploaded files on the local file system in a temporary directory.
    config.active_storage.service = :test

    # Don't generate system test files.
    config.generators.system_tests = nil

    # ViewComponent
    config.view_component.preview_paths << Rails.root.join("previews").to_s
    config.view_component.view_component_path = Rails.root.join("../app/components").to_s
    config.view_component.preview_controller = "PreviewController"
    config.view_component.show_previews = true

    # Lookbook
    config.lookbook.project_name = "Pulse ViewComponents"
    config.lookbook.page_paths = [Rails.root.join("..", "previews")]
    config.lookbook.component_paths = [Pulse::ViewComponents::Engine.root.join("app", "components")]
  end
end
