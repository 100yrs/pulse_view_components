# frozen_string_literal: true

module Pulse
  # Base Text component
  class Text < Pulse::Component
    STYLE_MAPPINGS = {
      h1: 'pulse-text-3xl pulse-font-bold print:pulse-text-2xl',
      h2: 'pulse-text-2xl pulse-font-bold print:pulse-text-xl',
      h3: 'pulse-text-xl pulse-font-bold print:pulse-text-lg',
      h4: 'pulse-text-lg pulse-font-bold print:pulse-text-base',
      subtitle: 'pulse-text-xl print:pulse-text-lg pulse-leading-tight ' \
                'pulse-font-bold tracking-tight',
      body1: 'pulse-text-lg print:pulse-text-base pulse-font-bold ' \
             'pulse-leading-6 tracking-tight',
      body2: 'pulse-text-lg print:pulse-text-base pulse-font-normal ' \
             'pulse-leading-6 tracking-tight',
      body3: 'pulse-text-base print:pulse-text-sm pulse-font-bold ' \
             'pulse-leading-normal',
      body4: 'pulse-text-base print:pulse-text-sm pulse-font-normal ' \
             'pulse-leading-normal',
      body5: 'pulse-text-sm print:pulse-text-xs pulse-font-bold ' \
             'pulse-leading-snug',
      body6: 'pulse-text-sm print:pulse-text-xs pulse-font-normal ' \
             'pulse-leading-snug',
      body7: 'pulse-text-xs pulse-font-bold pulse-leading-5',
      body8: 'pulse-text-xs pulse-font-normal pulse-leading-5',
      caption1: 'pulse-text-2xs pulse-font-bold tracking-normal ' \
                'pulse-leading-extra-tight',
      caption2: 'pulse-text-2xs pulse-font-normal tracking-normal ' \
                'pulse-leading-extra-tight'
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
