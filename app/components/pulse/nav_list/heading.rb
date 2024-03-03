# frozen_string_literal: true

module Pulse
  class NavList
    # The heading placed above a `NavList`'s items.
    #
    # See <%= link_to_component(NavList) %> for usage examples.
    class Heading < Component
      attr_reader :title, :id, :heading_level, :system_arguments

      # @param title [String] The text content of the heading.
      # @param id [String] The value of the ID HTML attribute. Auto-generated by default.
      # @param heading_level [Integer] The heading level, i.e. 2 for an `<h2>`, 3 for an `<h3>`, etc.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(title:, id: self.class.generate_id, heading_level: 2,
                     **system_arguments)
        @title = title
        @id = id
        @heading_level = heading_level
        @system_arguments = system_arguments
      end

      def call
        render(
          Pulse::Text.new(type: :body4, tag: "h#{heading_level}".to_sym, id: id, classes: 'ml-2 mb-4', **system_arguments).with_content(title)
        )
      end
    end
  end
end
