# frozen_string_literal: true

module Pulse
  # @label BorderBox
  class BorderBoxPreview < ViewComponent::Preview
    # @label Default
    def default
      render(Pulse::BorderBox.new) do |component|
        component.with_header { 'Header' }
        component.with_body { 'Body' }
        component.with_row { 'Row one' }
        component.with_row { 'Row two' }
        component.with_row { 'Row three' }
        component.with_footer { 'Footer' }
      end
    end

    # @label Body only
    def body_only
      render(Pulse::BorderBox.new) do |component|
        component.with_body { 'Body' }
      end
    end

    # @label Header with title
    def header_with_title
      render(Pulse::BorderBox.new) do |component|
        component.with_header do |header|
          header.with_title(tag: :h2) do
            'Header with title'
          end
        end
        component.with_body { 'Body' }
        component.with_footer { 'Footer' }
      end
    end

    # @label Row colors
    def row_colors
      render(Pulse::BorderBox.new) do |component|
        component.with_row(scheme: :default) { 'Default' }
        component.with_row(scheme: :neutral) { 'Neutral' }
        component.with_row(scheme: :info) { 'Info' }
        component.with_row(scheme: :warning) { 'Warning' }
      end
    end
  end
end
