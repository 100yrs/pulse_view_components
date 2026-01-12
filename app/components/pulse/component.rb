# frozen_string_literal: true

require 'tailwind_merge'

module Pulse
  # This core `Component` class provides a place to include shared modules
  # and helper methods that can be used by any child component.
  class Component < ViewComponent::Base
    TW_MERGE = TailwindMerge::Merger.new(config: { prefix: 'pulse-' })

    include AttributesHelper
    include FetchOrFallbackHelper
    include SvgHelper

    # include Pulse::ViewHelper

    delegate :inline_svg_tag, :inline_svg, to: :helpers

    # Merge nested attributes together. Particularly helpful when combining
    # data attributes without squashing previously existing data.
    #
    # For example:
    #
    # ```ruby
    # data = { data: { controller: "gallery" } }
    #
    # @options[:data] = merge_attributes(
    #   data,
    #   action: "click->gallery#next",
    # )
    # ```
    #
    # Returns:
    #
    # ```ruby
    # @options[:data]
    #   # => { controller: "gallery", action: "click->gallery#next" }
    # ```
    #
    def merge_attributes(*args)
      args = Array.new(2) { {} } if args.compact.blank?
      hashed_args = args.map { |el| el.presence || {} }

      hashed_args.first.deep_merge(hashed_args.second) do |_key, val, other_val|
        val + " #{other_val}"
      end
    end

    def merge_classes(*args)
      args = args.compact_blank
      return '' if args.empty?

      classes = class_names(*args)
      return classes unless args.many?

      # Handle arbitrary variants, which `class_names` will escape
      classes = CGI.unescapeHTML(classes) if classes.include?('[&')

      TW_MERGE.merge(classes)
    end

    def self.generate_id(base_name: name.demodulize.underscore.dasherize)
      "#{base_name}-#{SecureRandom.uuid}"
    end

    private

    def raise_on_invalid_options?
      true
      # Rails.application.config.primer_view_components.raise_on_invalid_options
    end

    def deny_single_argument(key, help_text, **arguments)
      raise ArgumentError, "`#{key}` is an invalid argument. #{help_text}" \
        if should_raise_error? && arguments.key?(key)

      arguments.except!(key)
    end

    def deny_aria_key(key, help_text, **arguments)
      raise ArgumentError, help_text if should_raise_aria_error? &&
                                        aria(key, arguments)
    end

    def deny_tag_argument(**arguments)
      deny_single_argument(:tag, 'This component has a fixed tag.', **arguments)
    end

    def should_raise_error?
      !Rails.env.production? &&
        raise_on_invalid_options? &&
        !ENV['PULSE_WARNINGS_DISABLED']
    end

    def should_raise_aria_error?
      !Rails.env.production?
    end
  end
end
