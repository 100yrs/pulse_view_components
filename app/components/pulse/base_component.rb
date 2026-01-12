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
    def initialize(tag:, classes: nil, **system_arguments)
      @tag = tag
      @classes = classes
      @system_arguments = system_arguments
    end

    def call
      content_tag(@tag, content, class: @classes, **@system_arguments)
    end
  end
end
