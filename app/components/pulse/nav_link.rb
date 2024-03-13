# frozen_string_literal: true

module Pulse
  # Links in navbars
  class NavLink < Pulse::Component
    DEFAULT_VARIANT = :desktop
    VARIANT_MAPPINGS = {
      desktop: 'pulse-px-3 pulse-py-2',
      mobile: 'pulse-px-3 pulse-py-2'
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys.freeze

    def initialize(label:, path:, active_mode: :inclusive, variant: :desktop,
                   **system_arguments)
      super

      @label = label
      @path = path
      @active_mode = active_mode
      @variant = variant
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div
    end
  end
end
