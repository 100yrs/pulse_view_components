# frozen_string_literal: true

module Pulse
  # `Box` is a basic wrapper component for most layout related needs.
  class Box < Component
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)

      @system_arguments[:tag] = :div
    end

    def call
      render(Pulse::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
