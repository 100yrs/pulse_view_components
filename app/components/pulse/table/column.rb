# frozen_string_literal: true

module Pulse
  class Table
    # Encapsulates table column properties
    class Column < Pulse::Component
      attr_reader :title, :sr_title, :sort_by, :footer, :options

      def initialize(title: '', sr_title: nil, sort_by: nil, footer: nil,
                     **options, &block)
        @title = title
        @sr_title = sr_title
        @sort_by = sort_by
        @footer = footer
        @block = block
        @options = options
      end

      delegate :call, to: :@block
    end
  end
end
