# frozen_string_literal: true

module Pulse
  # Base Text component
  class Text < Component
    STYLE_MAPPINGS = {
      h1: 'text-3xl font-bold print:text-2xl',
      h2: 'text-2xl font-bold print:text-xl',
      h3: 'text-xl font-bold print:text-lg',
      h4: 'text-lg font-bold print:text-base',
      subtitle: 'text-xl print:text-lg leading-tight font-bold tracking-tight',
      body1: 'text-lg print:text-base font-bold leading-6 tracking-tight',
      body2: 'text-lg print:text-base font-normal leading-6 tracking-tight',
      body3: 'text-base print:text-sm font-bold leading-normal',
      body4: 'text-base print:text-sm font-normal leading-normal',
      body5: 'text-sm print:text-xs font-bold leading-snug',
      body6: 'text-sm print:text-xs font-normal leading-snug',
      body7: 'text-xs font-bold leading-5',
      body8: 'text-xs font-normal leading-5',
      caption1: 'text-2xs font-bold tracking-normal leading-extra-tight',
      caption2: 'text-2xs font-normal tracking-normal leading-extra-tight'
    }.freeze

    TAG_MAPPINGS = {
      h1: :h1,
      h2: :h2,
      h3: :h3,
      h4: :h4,
      subtitle: :h2,
      body1: :p,
      body2: :p,
      body3: :p,
      body4: :p,
      body5: :p,
      body6: :p,
      body7: :p,
      body8: :p,
      caption1: :p,
      caption2: :p
    }.freeze

    def initialize(type:, **system_arguments)
      super

      @system_arguments = system_arguments
      @system_arguments[:classes] = merge_classes(
        STYLE_MAPPINGS[type],
        system_arguments[:classes]
      )
      @system_arguments[:tag] ||= TAG_MAPPINGS[type]
    end

    def tag
      @el_tag || TAG_MAPPINGS[@type]
    end

    def call
      render Pulse::BaseComponent.new(**@system_arguments).with_content(content)
    end

    def render?
      content.present?
    end
  end
end
