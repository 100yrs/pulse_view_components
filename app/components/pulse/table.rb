# frozen_string_literal: true

module Pulse
  # Renders a table
  # Inspiration taken from
  # https://github.com/baoagency/polaris_view_components/
  class Table < Pulse::Component
    DEFAULT_TABLE_CLASSES = 'min-w-full divide-y divide-gray-200'
    DEFAULT_HEAD_CLASSES = 'bg-gray-50'
    DEFAULT_TH_CLASSES = 'text-start text-gray uppercase tracking-wider ' \
                         'px-4 print:px-2 py-4 print:py-3 text-xs font-medium'
    DEFAULT_BODY_CLASSES = 'bg-white divide-y divide-gray-200 ' \
                           'print:divide-gray-400 text-sm leading-extra-snug ' \
                           'tracking-tight border-gray-200 ' \
                           'print:border-gray-400'
    DEFAULT_ROW_CLASSES = 'border-secondary-300'
    DEFAULT_TD_CLASSES = 'px-4 print:px-2 py-4'

    renders_many :columns, lambda { |**options, &block|
      Pulse::Tables::Column.new(**options, &block)
    }
    renders_one :empty_state, Pulse::BlankSlate

    attr_reader :collection, :additional_params, :pagination, :striped,
                :full_width, :current_sort_column, :current_sort_direction,
                :hoverable, :row_classes, :header

    def initialize(collection, additional_params: {}, pagination: true,
                   striped: false, current_sort_column: nil,
                   current_sort_direction: nil, hoverable: false,
                   row_classes: nil, header: true, **options)
      super

      @collection = collection
      @additional_params = additional_params
      @pagination = pagination
      @striped = striped
      @current_sort_column = current_sort_column
      @current_sort_direction = current_sort_direction
      @hoverable = hoverable
      @row_classes = row_classes
      @header = header
      @options = options
    end

    def pagination?
      pagination
    end

    def footer
      columns.any?(&:footer)
    end

    def table_options
      { tag: 'table' }.deep_merge(@options).tap do |args|
        args[:classes] = merge_classes(
          DEFAULT_TABLE_CLASSES,
          'container mx-auto',
          args[:classes]
        )
        args[:data] ||= {}
      end
    end

    def head_classes
      merge_classes(
        DEFAULT_HEAD_CLASSES,
        @options[:head_classes]
      )
    end

    def head_cell_classes
      merge_classes(
        DEFAULT_TH_CLASSES
      )
    end

    def body_classes
      merge_classes(
        DEFAULT_BODY_CLASSES,
        '[&>tr:nth-child(even)]:bg-gray-50': striped,
        'border-b [&>tr]:border-t [&>tr:first-child]:border-t-0': !striped
      )
    end

    def row_arguments(row)
      { tag: 'tr' }.tap do |args|
        args[:classes] = merge_classes(
          DEFAULT_ROW_CLASSES,
          { 'hover:bg-dark-charcoal-50': hoverable },
          row_classes
        )
        args[:id] = dom_id(row) if row.respond_to?(:to_key)
        args[:data] ||= {}
      end
    end

    def render_cell(**arguments, &)
      render(
        Pulse::Tables::Cell.new(
          additional_params: additional_params,
          **arguments
        ),
        &
      )
    end
  end
end
