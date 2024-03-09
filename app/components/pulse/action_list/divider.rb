# frozen_string_literal: true

module Pulse
  class ActionList
    # Separator with optional text rendered above groups or between individual items.
    class Divider < Pulse::Component
      DEFAULT_SCHEME = :subtle
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => nil,
        :filled => 'pulse-border-t-color-gray pulse-border-b-color-gray ' \
                   'pulse-border-y-solid empty:pulse-h-2 empty:pulse-box-border'
      }.freeze
      SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

      # @param scheme [Symbol] Display a background color if scheme is `filled`.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(scheme: DEFAULT_SCHEME, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :li
        @system_arguments[:role] = :presentation
        @system_arguments[:'aria-hidden'] = true
        @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
        @system_arguments[:classes] = merge_classes(
          'pulse-block pulse-h-[1px] pulse-p-0 pulse-border-0 pulse-ms-2 ',
          'pulse-me-2 pulse-bg-gray-100',
          SCHEME_MAPPINGS[@scheme]
        )
      end

      def call
        render(Pulse::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
