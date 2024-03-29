# frozen_string_literal: true

module Pulse
  class BorderBox
    # `BorderBox::Header` is used inside `BorderBox` to render its header slot.
    #
    # @accessibility When using `header.with_title`, set `tag` to one of `h1`, `h2`, `h3`, etc. based on what is appropriate for the page context. <%= link_to_heading_practices %>
    class Header < Pulse::Component
      attr_reader :id

      TITLE_TAG_FALLBACK = :h2
      TITLE_TAG_OPTIONS = [:h1, TITLE_TAG_FALLBACK, :h3, :h4, :h5, :h6].freeze

      # Optional Title.
      #
      # @param tag [Symbol] <%= one_of(Pulse::BorderBox::Header::TITLE_TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :title, lambda { |tag:, **system_arguments|
        system_arguments[:tag] = fetch_or_fallback(
          TITLE_TAG_OPTIONS,
          tag,
          TITLE_TAG_FALLBACK
        )
        system_arguments[:classes] = class_names(
          'Box-title',
          system_arguments[:classes]
        )

        Pulse::BaseComponent.new(**system_arguments)
      }

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:id] ||= self.class.generate_id
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          'pulse-px-4 pulse-py-5 pulse-bg-gray-50 sm:pulse-p-6',
          'pulse-rounded-t-md pulse-border-b pulse-border-gray-300',
          'pulse-border-solid',
          'Box-header',
          system_arguments[:classes]
        )
        @id = @system_arguments[:id]
      end
    end
  end
end
