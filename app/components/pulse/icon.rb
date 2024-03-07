# frozen_string_literal: true

module Pulse
  # Render icons from the images/icons directory.
  class Icon < Pulse::Component
    SIZE_DEFAULT = :sm
    SIZE_MAPPINGS = {
      xs: 12,
      sm: 16,
      md: 24
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    def initialize(icon: nil, size: SIZE_DEFAULT, **system_arguments)
      super

      @icon = "ui/icons/#{icon}"

      @system_arguments = system_arguments
      @system_arguments[:class] = class_names(
        'pulse-icon',
        system_arguments[:classes]
      )
      @system_arguments[:height] ||=
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
    end

    def call
      render_svg(@icon, **@system_arguments)
    end
  end
end
