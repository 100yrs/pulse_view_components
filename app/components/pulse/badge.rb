# frozen_string_literal: true

module Pulse
  # Renders a badge component
  # see: /lookbook/inspect/pulse/badge/default
  class Badge < Pulse::Component
    DEFAULT_TAG = :span
    TAG_OPTIONS = [DEFAULT_TAG, :summary, :a, :div].freeze

    DEFAULT_VARIANT = :standard
    VARIANT_MAPPINGS = {
      standard: 'pulse-inline-block pulse-rounded pulse-uppercase ' \
                'pulse-py-0.5 pulse-px-1.5 pulse-text-[10px] ' \
                'pulse-font-bold',
      pill: 'pulse-inline-block pulse-rounded-2xl pulse-min-w-[8rem] ' \
            'pulse-text-center pulse-p-2 pulse-text-sm ' \
            'pulse-leading-none pulse-font-bold'
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys.freeze

    DEFAULT_SCHEME = :secondary
    SCHEME_MAPPINGS = {
      primary: 'pulse-bg-primary pulse-text-white hover:pulse-text-white',
      secondary: 'pulse-bg-secondary pulse-text-white',
      secondary_outline: 'pulse-bg-white pulse-border pulse-border-secondary ' \
                         'pulse-text-secondary ' \
                         'pulse-hover:pulse-text-secondary',
      invited: 'pulse-bg-secondary-200 pulse-text-gray ' \
               'pulse-hover:pulse-text-gray',
      active: 'pulse-bg-success-200 pulse-text-gray hover:pulse-text-gray',
      disabled: 'pulse-bg-gray-100 pulse-text-gray hover:pulse-text-gray',
      info: 'pulse-bg-gray-600 pulse-text-white hover:pulse-text-white'
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

    def initialize(tag: DEFAULT_TAG, variant: DEFAULT_VARIANT,
                   scheme: DEFAULT_SCHEME, **system_arguments)
      @system_arguments = system_arguments

      @variant = fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)
      @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)

      @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
      @system_arguments[:classes] = merge_classes(
        VARIANT_MAPPINGS[@variant],
        SCHEME_MAPPINGS[@scheme],
        system_arguments[:classes]
      )
    end

    def call
      render(Pulse::BaseComponent.new(**@system_arguments)) { content }
    end

    def render?
      content.present?
    end
  end
end
