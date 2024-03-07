# frozen_string_literal: true

module Pulse
  # Use `Link` for navigating from one page to another.
  # `Link` styles anchor tags with default styling and hover
  # text-decoration.
  class Link < Pulse::Component
    DEFAULT_SCHEME = :tertiary
    SCHEME_MAPPINGS = {
      primary: 'text-primary hover:text-primary',
      secondary: 'text-secondary hover:text-secondary',
      tertiary: 'text-tertiary hover:text-tertiary',
      reversed: 'text-gray-200 hover:text-gray-200 focus:text-gray-200'
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
        'font-bold': bold,
        'underline hover:no-underline': condition && underline
      )
    end

    def before_render
      if @options[:href].nil? && @condition && !Rails.env.production?
        raise ArgumentError, 'href is required'
      end

      return unless leading_visual

      @options[:classes] = class_names(
        @options[:classes],
        'flex items-center gap-1.5'
      )
    end
  end
end
