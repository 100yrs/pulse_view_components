# frozen_string_literal: true

module Pulse
  # Conditionally renders a `BaseComponent` around the given content. If the given condition
  # is true, a `BaseComponent` will render around the content. If the condition is false, only
  # the content is rendered.
  class ConditionalWrapper < Pulse::Component
    # @param condition [Boolean] Whether or not to wrap the content in a `BaseComponent`.
    # @param base_component_arguments [Hash] The arguments to pass to `BaseComponent`.
    def initialize(condition:, **base_component_arguments)
      super

      @condition = condition
      @base_component_arguments = base_component_arguments
    end

    def call
      return content unless @condition

      BaseComponent.new(**@base_component_arguments).render_in(self) { content }
    end
  end
end
