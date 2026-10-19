# frozen_string_literal: true

module Pulse
  class ActionList
    # Separator with optional text rendered above groups or between individual items.
    class Divider < Pulse::Component
      status :alpha

      DEFAULT_SCHEME = :subtle
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => nil,
        :filled => 'pulse:border-t-color-gray pulse:border-b-color-gray ' \
                   'pulse:border-y-solid pulse:empty:h-2 pulse:empty:box-border'
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
          'pulse:block pulse:h-px pulse:p-0 pulse:border-0 pulse:ms-2 ',
          'pulse:me-2 pulse:bg-neutral-100',
          SCHEME_MAPPINGS[@scheme]
        )
      end

      def call
        render(Pulse::BaseComponent.new(**@system_arguments)) { content }
      end

      # `ActionList#items` yields slot wrappers, so `is_a?` cannot spot a
      # divider. The slot forwards `respond_to?` to this component instead.
      def divider?
        true
      end
    end
  end
end
