# frozen_string_literal: true

module Pulse
  class ActionList
    # Separator with optional text rendered above groups or between individual items.
    class Divider < Pulse::Component
      DEFAULT_SCHEME = :subtle
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => nil,
        :filled => 'border-t-color-gray border-b-color-gray border-y-solid empty:h-2 empty:box-border'
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
          'block h-[1px] p-0 border-0 ms-2 me-2 bg-gray-100',
          SCHEME_MAPPINGS[@scheme]
        )
      end

      def call
        render(Pulse::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
