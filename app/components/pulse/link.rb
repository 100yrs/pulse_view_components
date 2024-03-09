# frozen_string_literal: true

module Pulse
  # Use `Link` for navigating from one page to another.
  # `Link` styles anchor tags with default styling and hover
  # text-decoration.
  class Link < Pulse::Component
    DEFAULT_SCHEME = :tertiary
    SCHEME_MAPPINGS = {
      primary: 'pulse-text-primary hover:pulse-text-primary',
      secondary: 'pulse-text-secondary hover:pulse-text-secondary',
      tertiary: 'pulse-text-tertiary hover:pulse-text-tertiary',
      reversed: 'pulse-text-gray-200 hover:pulse-text-gray-200 ' \
                'focus:pulse-text-gray-200'
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

    renders_one :leading_visual, types: {
      icon: lambda { |**options|
        Pulse::Icon.new(**options)
      }
    }

    def initialize(href: nil, scheme: DEFAULT_SCHEME, bold: false,
                   underline: true, condition: true, **options)
      super

      @condition = condition
      @options = options
      @options[:tag] = condition ? :a : :span
      @options[:href] = href if condition
      @options[:classes] = merge_classes(
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme,
                                          DEFAULT_SCHEME)],
        @options[:classes],
        'pulse-font-bold': bold,
        'pulse-underline hover:pulse-no-underline': condition && underline
      )
    end

    def before_render
      if @options[:href].nil? && @condition && !Rails.env.production?
        raise ArgumentError, 'href is required'
      end

      return unless leading_visual

      @options[:classes] = class_names(
        @options[:classes],
        'pulse-flex pulse-items-center pulse-gap-1.5'
      )
    end
  end
end
