# frozen_string_literal: true

module Pulse
  # Renders a two-column page layout
  class Layout < Pulse::Component
    FIRST_IN_SOURCE_DEFAULT = :sidebar
    FIRST_IN_SOURCE_OPTIONS = [FIRST_IN_SOURCE_DEFAULT, :main].freeze

    GUTTER_DEFAULT = :default
    GUTTER_MAPPINGS = {
      # :none => "Layout--gutter-none",
      # :condensed => "Layout--gutter-condensed",
      # :spacious => "Layout--gutter-spacious",
      GUTTER_DEFAULT => ''
    }.freeze
    GUTTER_OPTIONS = GUTTER_MAPPINGS.keys.freeze

    SIDEBAR_WIDTH_DEFAULT = :default
    SIDEBAR_WIDTH_MAPPINGS = {
      SIDEBAR_WIDTH_DEFAULT => ''
      # :narrow => "Layout--sidebar-narrow",
      # :wide => "Layout--sidebar-wide"
    }.freeze
    SIDEBAR_WIDTH_OPTIONS = SIDEBAR_WIDTH_MAPPINGS.keys.freeze

    # The layout's main content.
    #
    # @param width [Symbol] <%= one_of(Layout::Main::WIDTH_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :main, 'Pulse::Layout::Main'

    # The layout's sidebar.
    #
    # @param width [Symbol] <%= one_of(Layout::SIDEBAR_WIDTH_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :sidebar, lambda { |
      width: SIDEBAR_WIDTH_DEFAULT,
      **system_arguments
    |
      # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
      @system_arguments[:classes] = merge_classes(
        @system_arguments[:classes],
        SIDEBAR_WIDTH_MAPPINGS[fetch_or_fallback(SIDEBAR_WIDTH_OPTIONS, width,
                                                 SIDEBAR_WIDTH_DEFAULT)]
      )

      Pulse::Layout::Sidebar.new(**system_arguments)
    }

    # @param first_in_source [Symbol] Which element to render first in the HTML. This will change the keyboard navigation order. <%= one_of(Layout::FIRST_IN_SOURCE_OPTIONS) %>
    # @param gutter [Symbol] The amount of space between the main section and the sidebar. <%= one_of(Layout::GUTTER_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(first_in_source: FIRST_IN_SOURCE_DEFAULT, gutter: :default,
                   **system_arguments)
      @first_in_source = fetch_or_fallback(
        FIRST_IN_SOURCE_OPTIONS,
        first_in_source,
        FIRST_IN_SOURCE_OPTIONS
      )

      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = merge_classes(
        'pulse-grid pulse-grid-flow-col',
        'pulse-grid-cols-[auto_0_minmax(0,calc(100%_-_var(--pulse-layout' \
        '-sidebar-width)_-_var(--pulse-layout-gutter)))]',
        'pulse-gap-[var(--pulse-layout-gutter)]',
        GUTTER_MAPPINGS[fetch_or_fallback(GUTTER_OPTIONS, gutter,
                                          GUTTER_DEFAULT)],
        system_arguments[:classes]
      )
    end

    def render?
      main? && sidebar?
    end

    # The layout's main content.
    class Main < Pulse::Component
      WIDTH_DEFAULT = :full
      WIDTH_OPTIONS = [WIDTH_DEFAULT, :md, :lg, :xl].freeze

      TAG_DEFAULT = :div
      TAG_OPTIONS = [TAG_DEFAULT, :main].freeze

      # @param width [Symbol] <%= one_of(Layout::Main::WIDTH_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(tag: TAG_DEFAULT, width: WIDTH_DEFAULT, **system_arguments)
        @width = fetch_or_fallback(WIDTH_OPTIONS, width, WIDTH_DEFAULT)

        @system_arguments = system_arguments
        @system_arguments[:tag] =
          fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
        @system_arguments[:classes] = merge_classes(
          'pulse-col-[2_/_span_2]',
          system_arguments[:classes]
        )
      end

      def call
        render(Pulse::BaseComponent.new(**@system_arguments)) do
          if @width == :full
            content
          else
            render(Pulse::BaseComponent.new(tag: :div,
                                            classes: "pulse-mx-auto Layout-main-centered-#{@width}")) do
              render(Pulse::BaseComponent.new(tag: :div, container: @width)) do
                content
              end
            end
          end
        end
      end
    end

    # The layout's sidebar content.
    class Sidebar < Pulse::Component
      TAG_DEFAULT = :div
      TAG_OPTIONS = [TAG_DEFAULT, :aside, :nav, :section].freeze

      def initialize(tag: TAG_DEFAULT, **system_arguments)
        @system_arguments = system_arguments

        @system_arguments[:tag] =
          fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
        @system_arguments[:classes] = merge_classes(
          'pulse-col-[1]',
          @system_arguments[:classes]
        )
      end

      def call
        render(Pulse::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
