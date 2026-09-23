# frozen_string_literal: true

module Pulse
  # BaseComponent accepts a standard set of options, providing the
  # foundation for other components to use and build upon. Specify a tag,
  # optional classes, and any other additional options will be passed to
  # Rails' `content_tag` helper.
  #
  # This is a simplified version of Primer's `BaseComponent`
  #
  # For example:
  #
  # ```erb
  # <%= render Pulse::BaseComponent.new(tag: :span, classes: "text-sm") do %>
  #   Hello world
  # <% end %>
  # ```
  #
  # Renders:
  #
  # ```html
  # <span class="text-sm">Hello world</span>
  # ```
  #
  class BaseComponent < Pulse::Component
    # @param system_arguments_denylist [Hash] Maps arrays of denied argument
    #   keys to help text. Consumed here and never rendered as an attribute.
    def initialize(tag:, classes: nil, system_arguments_denylist: {},
                   **system_arguments)
      @tag = tag
      @classes = classes
      @system_arguments = system_arguments
      validate_denylist(system_arguments_denylist)
    end

    def call
      content_tag(@tag, content, class: @classes, **@system_arguments)
    end

    private

    def validate_denylist(denylist)
      return unless should_raise_error?

      denylist.each do |keys, help_text|
        denied = keys & @system_arguments.keys
        next if denied.empty?

        raise ArgumentError,
              "#{denied.map { |key| "`#{key}`" }.to_sentence} " \
              "#{denied.one? ? 'is an' : 'are'} invalid " \
              "#{denied.one? ? 'argument' : 'arguments'}. #{help_text}"
      end
    end
  end
end
