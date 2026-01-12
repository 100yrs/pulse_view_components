# frozen_string_literal: true

require 'rails/engine'
require 'view_component'
# require 'view_component/version'

module Pulse
  module ViewComponents
    # :nodoc:
    class Engine < ::Rails::Engine
      isolate_namespace Pulse::ViewComponents

      %W(
        #{root}/app/components
        #{root}/lib
      ).each { |path| config.autoload_paths << path }

      # config.eager_load_paths = %W[
      #   #{root}/app/components
      #   #{root}/app/forms
      #   #{root}/app/helpers
      #   #{root}/app/lib
      # ]
      config.eager_load_paths = %W(
        #{root}/app/components
        #{root}/app/lib
      )

      # config.pulse_view_components = ActiveSupport::OrderedOptions.new

      # config.pulse_view_components.raise_on_invalid_options = false

      # initializer 'pulse_view_components.assets' do |app|
      #   if app.config.respond_to?(:assets)
      #     app.config.assets.precompile += %w(pulse_view_components)
      #   end
      # end

      # initializer 'pulse.eager_load_actions' do
      #   ActiveSupport.on_load(:after_initialize) do
      #     if Rails.application.config.eager_load
      #       # Pulse::Forms::Base.compile!
      #       # Pulse::Forms::Base.descendants.each(&:compile!)
      #       # Pulse::Forms::BaseComponent.descendants.each(&:compile!)
      #       # Pulse::Octicon::Cache.preload!
      #     end
      #   end
      # end

      # Polaris

      # initializer "polaris_view_components.assets" do |app|
      #   if app.config.respond_to?(:assets)
      #     app.config.assets.precompile += %w[
      #       polaris_view_components.js polaris_view_components.css
      #     ]
      #   end
      # end

      # initializer "polaris_view_components.importmap", before: "importmap" do |app|
      #   if app.config.respond_to?(:importmap) && app.config.importmap.has_key?(:cache_sweepers)
      #     app.config.importmap.cache_sweepers << Engine.root.join("app/assets/javascripts")
      #   end
      # end

      # initializer "polaris_view_components.helpers" do
      #   ActiveSupport.on_load(:action_controller_base) do
      #     helper Polaris::ViewHelper
      #     helper Polaris::UrlHelper
      #   end
      # end
    end
  end
end
