# frozen_string_literal: true

module Pulse
  # @label Popover
  class PopoverPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param caret [Symbol] select [top, right, bottom, left, top_right, top_left, bottom_right, bottom_left, left_bottom, left_top, right_bottom, right_top]
    def playground(caret: :top)
      render Pulse::Popover.new do |component|
        component.with_heading do
          'Popover Heading'
        end
        component.with_body(caret: caret) do
          'This is the Popover body.'
        end
      end
    end

    # @label Default
    #
    # @param caret [Symbol] select [top, right, bottom, left, top_right, top_left, bottom_right, bottom_left, left_bottom, left_top, right_bottom, right_top]
    def default(caret: :top)
      render Pulse::Popover.new do |component|
        component.with_heading do
          'Popover Heading'
        end
        component.with_body(caret: caret) do
          'This is the Popover body.'
        end
      end
    end

    # @label Large
    def large
      render Pulse::Popover.new do |component|
        component.with_body(large: true) do
          'This is a large Popover body.'
        end
      end
    end

    # @!group Directions
    def bottom_right
      render Pulse::Popover.new do |component|
        component.with_body(caret: :bottom_right) do
          'This is the Popover body.'
        end
      end
    end

    def top_right
      render Pulse::Popover.new do |component|
        component.with_body(caret: :top_right) do
          'This is the Popover body.'
        end
      end
    end

    def bottom_left
      render Pulse::Popover.new do |component|
        component.with_body(caret: :bottom_left) do
          'This is the Popover body.'
        end
      end
    end

    def top_left
      render Pulse::Popover.new do |component|
        component.with_body(caret: :top_left) do
          'This is the Popover body.'
        end
      end
    end
    # @!endgroup
  end
end
