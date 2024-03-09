# frozen_string_literal: true

module Pulse
  # Renders a simple progress bar
  class ProgressBar < Pulse::Component
    def initialize(percentage: 0, **system_attributes)
      super

      @percentage = percentage.to_i
      @system_attributes = system_attributes
      @system_attributes[:tag] ||= :div
      @system_attributes[:class] = merge_classes(
        'pulse-flex pulse-flex-row pulse-h-1 pulse-w-full pulse-bg-gray-200',
        'dark:pulse-bg-gray-600',
        system_attributes[:classes]
      )
    end

    private

    def before_render
      @system_attributes[:title] ||= t('.title', percentage: @percentage)
    end
  end
end
