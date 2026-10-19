# frozen_string_literal: true

module Pulse
  # @label Popover
  class PopoverPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param caret [Symbol] select {{ Pulse::Popover::CARET_OPTIONS }}
    def playground(caret: :top)
      render Pulse::Popover.new do |component|
        component.with_heading do
          'Popover Heading'
        end
        component.with_body(caret:) do
          'This is the Popover body.'
        end
      end
    end

    # @label Default
    #
    # @param caret [Symbol] select {{ Pulse::Popover::CARET_OPTIONS }}
    def default(caret: :top)
      render Pulse::Popover.new do |component|
        component.with_heading do
          'Popover Heading'
        end
        component.with_body(caret:) do
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
    def top
      popover_with_caret(:top)
    end

    def top_left
      popover_with_caret(:top_left)
    end

    def top_right
      popover_with_caret(:top_right)
    end

    def bottom
      popover_with_caret(:bottom)
    end

    def bottom_left
      popover_with_caret(:bottom_left)
    end

    def bottom_right
      popover_with_caret(:bottom_right)
    end

    def left
      popover_with_caret(:left)
    end

    def left_top
      popover_with_caret(:left_top)
    end

    def left_bottom
      popover_with_caret(:left_bottom)
    end

    def right
      popover_with_caret(:right)
    end

    def right_top
      popover_with_caret(:right_top)
    end

    def right_bottom
      popover_with_caret(:right_bottom)
    end
    # @!endgroup

    private

    def popover_with_caret(caret)
      render Pulse::Popover.new(classes: 'pulse:m-8') do |component|
        component.with_body(caret:) do
          'This is the Popover body.'
        end
      end
    end
  end
end
