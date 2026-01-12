# frozen_string_literal: true

module Pulse
  # @label Layout
  class LayoutPreview < ViewComponent::Preview
    # @label Playground
    # @param first_in_source [Symbol] select [sidebar, main]
    # @param gutter [Symbol] select [default, none, condensed, spacious]
    def playground(first_in_source: :sidebar, gutter: :default)
      render(
        Pulse::Layout.new(gutter:, first_in_source:)
      ) do |component|
        component.with_main(classes: 'pulse-bg-blue-50') do
          'Main content'
        end
        component.with_sidebar(classes: 'pulse-bg-gray-50') do
          'Sidebar content'
        end
      end
    end

    # @label Default
    def default
      render(Pulse::Layout.new) do |component|
        component.with_main(classes: 'pulse-bg-blue-50') do
          'Main content'
        end
        component.with_sidebar(classes: 'pulse-bg-gray-50') do
          'Sidebar content'
        end
      end
    end
  end
end
