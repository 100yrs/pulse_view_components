# frozen_string_literal: true

module Pulse
  module Tables
    # Encapsulates table column properties
    class Column < Component
      attr_reader :title, :sr_title, :sort_by, :footer, :options

      def initialize(title: '', sr_title: nil, sort_by: nil, footer: nil,
                     **options, &block)
        super

        @title = title
        @sr_title = sr_title
        @sort_by = sort_by
        @footer = footer
        @block = block
        @options = options
      end

      def call(row)
        @block.call(row)
      end
    end
  end
end
