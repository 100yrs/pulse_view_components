# frozen_string_literal: true

module Pulse
  # Use `Popover` to bring attention to specific user interface elements,
  # typically to suggest an action or to guide users through a new experience.
  #
  # By default, the popover renders with absolute positioning, meaning it should
  # usually be wrapped in an element with a relative position in order to be
  # positioned properly. To render the popover with relative positioning, use
  # the relative property.
  class Popover < Pulse::Component
    # The caret is a white square rotated 45 degrees and drawn over the edge of
    # the body, with a border on the two sides that face outward.
    CARET_BASE = 'pulse:before:absolute pulse:before:size-3 ' \
                 'pulse:before:rotate-45 pulse:before:bg-white ' \
                 'pulse:before:border-gray-300'
    CARET_TOP = 'pulse:before:-top-1.5 pulse:before:border-t ' \
                'pulse:before:border-l'
    CARET_BOTTOM = 'pulse:before:-bottom-1.5 pulse:before:border-b ' \
                   'pulse:before:border-r'
    CARET_LEFT = 'pulse:before:-left-1.5 pulse:before:border-b ' \
                 'pulse:before:border-l'
    CARET_RIGHT = 'pulse:before:-right-1.5 pulse:before:border-t ' \
                  'pulse:before:border-r'
    CARET_CENTER_X = 'pulse:before:left-1/2 pulse:before:-translate-x-1/2'
    CARET_CENTER_Y = 'pulse:before:top-1/2 pulse:before:-translate-y-1/2'

    CARET_DEFAULT = :top
    CARET_MAPPINGS = {
      CARET_DEFAULT => "#{CARET_TOP} #{CARET_CENTER_X}",
      :top_left => "#{CARET_TOP} pulse:before:left-6",
      :top_right => "#{CARET_TOP} pulse:before:right-6",
      :bottom => "#{CARET_BOTTOM} #{CARET_CENTER_X}",
      :bottom_left => "#{CARET_BOTTOM} pulse:before:left-6",
      :bottom_right => "#{CARET_BOTTOM} pulse:before:right-6",
      :left => "#{CARET_LEFT} #{CARET_CENTER_Y}",
      :left_top => "#{CARET_LEFT} pulse:before:top-6",
      :left_bottom => "#{CARET_LEFT} pulse:before:bottom-6",
      :right => "#{CARET_RIGHT} #{CARET_CENTER_Y}",
      :right_top => "#{CARET_RIGHT} pulse:before:top-6",
      :right_bottom => "#{CARET_RIGHT} pulse:before:bottom-6"
    }.freeze
    CARET_OPTIONS = CARET_MAPPINGS.keys.freeze

    # Leaves room for the caret on the side it points from.
    CARET_MARGIN_MAPPINGS = {
      top: 'pulse:mt-2',
      bottom: 'pulse:mb-2',
      left: 'pulse:ml-2',
      right: 'pulse:mr-2'
    }.freeze

    DEFAULT_WIDTH = 'pulse:w-64'
    LARGE_WIDTH = 'pulse:w-80'

    DEFAULT_HEADING_TAG = :h4

    # The heading
    #
    # @param tag [Symbol] (Pulse::Popover::DEFAULT_HEADING_TAG) <%= one_of(Pulse::Heading::TAG_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :heading, lambda { |tag: DEFAULT_HEADING_TAG,
                                    **system_arguments|
      system_arguments[:type] = :body3
      system_arguments[:tag] = tag
      system_arguments[:classes] = merge_classes(
        'pulse:mb-2',
        system_arguments[:classes]
      )

      Pulse::Text.new(**system_arguments)
    }

    # The body
    #
    # @param caret [Symbol] <%= one_of(Pulse::Popover::CARET_MAPPINGS.keys) %>
    # @param large [Boolean] Whether to use the large version of the component.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :body, lambda { |caret: CARET_DEFAULT, large: false,
                                 **system_arguments|
      caret = fetch_or_fallback(CARET_OPTIONS, caret, CARET_DEFAULT)
      side = caret.to_s.split('_').first.to_sym
      @large = large

      @body_arguments = system_arguments
      @body_arguments['data-caret'] = caret
      @body_arguments[:classes] = merge_classes(
        'pulse:relative pulse:bg-white pulse:border pulse:border-gray-300',
        'pulse:rounded-lg pulse:p-4 pulse:text-left pulse:shadow-lg',
        CARET_MARGIN_MAPPINGS[side],
        CARET_BASE,
        CARET_MAPPINGS[caret],
        system_arguments[:classes]
      )

      Pulse::Content.new
    }

    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:tag] = :div
    end

    def render?
      body.present?
    end

    # Built from the template because the body slot, which sets `large`, is
    # only evaluated once rendering starts.
    def wrapper_arguments
      @system_arguments.merge(
        classes: merge_classes(
          'pulse:relative pulse:z-10',
          @large ? LARGE_WIDTH : DEFAULT_WIDTH,
          @system_arguments[:classes]
        )
      )
    end

    def body_component
      Pulse::Box.new(**@body_arguments)
    end
  end
end
