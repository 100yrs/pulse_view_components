# frozen_string_literal: true

module Pulse
  # A kind of badge. Used for displaying github labels. Perhaps could be
  # consolidated with badges?
  # Accepts Hex color value for bg_color, with or without a leading "#"
  class Label < Pulse::Component
    def initialize(title:, bg_color: 'ffffff', **options)
      @title = title
      @bg_color = bg_color || 'ffffff'
      @options = options
      @options[:classes] = merge_classes(
        'pulse-px-2 pulse-inline-flex pulse-text-xs print:pulse-text-2xs',
        'pulse-leading-5 pulse-font-semibold pulse-rounded-full',
        text_color,
        options[:classes]
      )
      @options[:tag] ||= :span
    end

    def text_color
      @bg_color = @bg_color[1..] if @bg_color[0] == '#'

      r, g, b = @bg_color.scan(/../).map { |color| color.to_i(16) }

      # Normalize RGB values to 0-1
      r_norm = r / 255.0
      g_norm = g / 255.0
      b_norm = b / 255.0

      # Calculate luminance
      luminance = (0.2126 * r_norm) + (0.7152 * g_norm) + (0.0722 * b_norm)

      # Choose text color based on luminance
      luminance > 0.5 ? 'pulse-text-black' : 'pulse-text-white'
    end

    private

    attr_reader :title, :bg_color
  end
end
