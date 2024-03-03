# frozen_string_literal: true

module Pulse
  # Use `Popover` to bring attention to specific user interface elements,
  # typically to suggest an action or to guide users through a new experience.
  #
  # By default, the popover renders with absolute positioning, meaning it should
  # usually be wrapped in an element with a relative position in order to be
  # positioned properly. To render the popover with relative positioning, use
  # the relative property.
  class Popover < Component
    CARET_DEFAULT = :top
    CARET_MAPPINGS = {
      CARET_DEFAULT => 'caret-top',
      :bottom => 'caret-bottom',
      :bottom_right => 'Popover-message--bottom-right',
      :bottom_left => 'Popover-message--bottom-left',
      :left => 'caret-left',
      :left_bottom => 'Popover-message--left-bottom',
      :left_top => 'Popover-message--left-top',
      :right => 'caret-right',
      :right_bottom => 'Popover-message--right-bottom',
      :right_top => 'Popover-message--right-top',
      :top_left => 'Popover-message--top-left',
      :top_right => 'Popover-message--top-right'
    }.freeze

    DEFAULT_HEADING_TAG = :h4

    # The heading
    #
    # @param tag [Symbol] (Pulse::Popover::DEFAULT_HEADING_TAG) <%= one_of(Pulse::Heading::TAG_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :heading, lambda { |tag: DEFAULT_HEADING_TAG, **system_arguments|
      system_arguments[:type] = :body3
      system_arguments[:tag] = tag
      system_arguments[:classes] = merge_classes(
        'mb-2',
        system_arguments[:classes]
      )

      Pulse::Text.new(**system_arguments)
    }

    # The body
    #
    # @param caret [Symbol] <%= one_of(Pulse::Popover::CARET_MAPPINGS.keys) %>
    # @param large [Boolean] Whether to use the large version of the component.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :body, lambda { |caret: CARET_DEFAULT, large: false, **system_arguments|
      @body_arguments = system_arguments
      @body_arguments['data-caret'] = caret
      @body_arguments[:classes] = merge_classes(
        @body_arguments[:classes],
        CARET_MAPPINGS[fetch_or_fallback(CARET_MAPPINGS.keys, caret,
                                         CARET_DEFAULT)],
        'Popover-message--large' => large
      )
      @body_arguments[:classes] = merge_classes(
        @body_arguments[:classes],
        'bg-white border border-gray-200 rounded-lg p-4 mt-2 mx-auto text-left shadow-lg'
      )

      Pulse::Content.new
    }

    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = merge_classes(
        'relative z-10 w-64',
        system_arguments[:classes]
      )
    end

    def render?
      body.present?
    end

    def body_component
      Pulse::Box.new(**@body_arguments)
    end
  end
end
