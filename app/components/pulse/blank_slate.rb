# frozen_string_literal: true

module Pulse
  # Use as placeholder when content is missing
  class BlankSlate < Pulse::Component
    renders_one :title
    renders_one :description

    def initialize(**system_arguments)
      super

      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div
      @system_arguments[:classes] = merge_classes(
        'pulse-container pulse-text-center pulse-pt-16 pulse-pb-20 ',
        'pulse-bg-secondary-50',
        system_arguments[:classes]
      )
    end
  end
end
