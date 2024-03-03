# frozen_string_literal: true

module Pulse
  # Renders a badge component
  # see: /lookbook/inspect/pulse/badge/default
  class Badge < Component
    DEFAULT_TAG = :span
    TAG_OPTIONS = [DEFAULT_TAG, :summary, :a, :div].freeze

    DEFAULT_VARIANT = :standard
    VARIANT_MAPPINGS = {
      standard: 'inline-block rounded uppercase py-0.5 px-1.5 text-[10px] ' \
                'font-bold',
      pill: 'inline-block rounded-2xl min-w-[8rem] text-center p-2 text-sm ' \
            'leading-none font-bold'
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys.freeze

    DEFAULT_SCHEME = :secondary
    SCHEME_MAPPINGS = {
      primary: 'bg-primary text-white hover:text-white',
      secondary: 'bg-secondary text-white',
      secondary_outline: 'bg-white border border-secondary text-secondary ' \
                         'hover:text-secondary',
      invited: 'bg-secondary-200 text-gray hover:text-gray',
      active: 'bg-success-200 text-gray hover:text-gray',
      disabled: 'bg-gray-100 text-gray hover:text-gray'
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

    def initialize(tag: DEFAULT_TAG, variant: DEFAULT_VARIANT,
                   scheme: DEFAULT_SCHEME, **system_arguments)
      super

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
