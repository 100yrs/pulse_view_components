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

require 'view_component'
require 'pulse/view_components'
require 'pulse/view_components/engine'

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
    # config.view_component.preview_paths << Rails.root.join("previews").to_s
    # config.view_component.view_component_path = Rails.root.join("../app/components").to_s
    # config.view_component.preview_controller = "PreviewController"
    # config.view_component.show_previews = true
    config.view_component.default_preview_layout = 'component_preview'
    config.view_component.show_previews = true
    config.view_component.preview_controller = 'PreviewController'
    config.view_component.preview_paths << Rails.root.join('../previews')

    # Lookbook
    # POLARIS CONFIG
    # config.lookbook.project_name = "Pulse ViewComponents"
    # config.lookbook.page_paths = [Rails.root.join("..", "previews")]
    # config.lookbook.component_paths = [Pulse::ViewComponents::Engine.root.join("app", "components")]

    # ORIGINAL PULSE APP CONFIG
    # config.view_component.generate.preview = true
    # config.view_component.preview_paths <<
    #   Rails.root.join('doc/lookbook/component_previews')
    # config.view_component.default_preview_layout = 'component_preview'

    # config.lookbook.page_paths = ['doc/lookbook/pages']
    # config.lookbook.project_name = 'Pulse Components'
    # config.lookbook.ui_theme = 'zinc'

    # PRIMER CONFIG
    if config.respond_to?(:lookbook)
      # asset_panel_config = {
      #   label: "Assets",
      #   partial: "lookbook/panels/assets",
      #   locals: lambda do |data|
      #     assets = data.preview.components.flat_map do |component|
      #       asset_files = Dir[Pulse::ViewComponents.root.join("app", "components", "#{component.relative_file_path.to_s.chomp('.rb')}.{css,ts}")]
      #       asset_files.map do |path_str|
      #         path = Pathname(path_str)
      #         { path: path, language: path.extname == ".ts" ? :js : :css }
      #       end
      #     end

      #     assets += data.scenarios.each_with_object([]) do |rendered_scenario, memo|
      #       form_constants = rendered_scenario.source.match(/([\w:]+Form)\.new/)&.captures || []
      #       form_constants.each do |form_constant|
      #         path, = Kernel.const_source_location(form_constant)
      #         memo << { path: Pathname(path), language: :ruby }

      #         const = Kernel.const_get(form_constant)
      #         next unless const.template_root_path

      #         Dir[File.join(const.template_root_path, "*_caption.html.erb")].each do |template_caption_path|
      #           memo << { path: Pathname(template_caption_path), language: :erb }
      #         end

      #         after_content_path = Pathname(File.join(const.template_root_path, "after_content.html.erb"))
      #         memo << { path: after_content_path, language: :erb } if after_content_path.exist?
      #       end
      #     end

      #     { assets: assets }
      #   end
      # }
      # Lookbook.add_panel("assets", asset_panel_config)

      config.lookbook.project_name = "Pulse ViewComponents v#{Pulse::ViewComponents::VERSION::STRING}"
      config.lookbook.preview_display_options = {
        theme: [
          ['Light default', 'light'],
          ['Light colorblind', 'light_colorblind'],
          ['Light high contrast', 'light_high_contrast'],
          ['Dark default', 'dark'],
          ['Dark Dimmed', 'dark_dimmed'],
          ['Dark high contrast', 'dark_high_contrast'],
          ['Dark colorblind', 'dark_colorblind'],
          ['All themes', 'all']
        ],
        primitives: [
          ['Next Major v8', 'next_major_v8'],
          ['Default', 'default']
        ]
      }

      config.lookbook.preview_embeds.policy = 'ALLOWALL'
      config.lookbook.page_paths = [Rails.root.join('../previews/pages')]
      config.lookbook.component_paths = [Pulse::ViewComponents::Engine.root.join(
        'app', 'components'
      )]
    end
  end
end
