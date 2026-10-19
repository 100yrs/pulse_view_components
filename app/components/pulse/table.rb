# frozen_string_literal: true

module Pulse
  # Renders a table
  # Inspiration taken from
  # https://github.com/baoagency/polaris_view_components/
  class Table < Pulse::Component
    status :stable

    DEFAULT_TABLE_CLASSES = 'pulse:min-w-full pulse:divide-y ' \
                            'pulse:divide-neutral-300'
    DEFAULT_HEAD_CLASSES = 'pulse:bg-neutral-100'
    DEFAULT_TH_CLASSES = 'pulse:text-start pulse:text-neutral-700 ' \
                         'pulse:uppercase ' \
                         'pulse:tracking-wider pulse:px-4 pulse:print:px-2 ' \
                         'pulse:py-4 pulse:print:py-3 pulse:text-xs ' \
                         'pulse:font-medium'
    DEFAULT_BODY_CLASSES = 'pulse:bg-white pulse:divide-y pulse:text-sm ' \
                           'pulse:leading-snug pulse:divide-neutral-300 ' \
                           'pulse:print:divide-neutral-400 pulse:tracking-tight'
    DEFAULT_ROW_CLASSES = 'pulse:border-secondary-300'
    DEFAULT_TD_CLASSES = 'pulse:px-4 pulse:print:px-2 pulse:py-4'

    delegate :paginate, to: :helpers

    renders_many :columns, lambda { |**options, &block|
      Pulse::Table::Column.new(**options, &block)
    }
    renders_one :empty_state, Pulse::BlankSlate

    attr_reader :collection, :additional_params, :pagination, :striped,
                :full_width, :current_sort_column, :current_sort_direction,
                :hoverable, :row_classes, :header, :scroll

    def initialize(collection, additional_params: {}, pagination: true,
                   striped: false, current_sort_column: nil,
                   current_sort_direction: nil, hoverable: false,
                   row_classes: nil, header: true, scroll: true, **options)
      @collection = collection
      @additional_params = additional_params
      @pagination = pagination
      @striped = striped
      @current_sort_column = current_sort_column
      @current_sort_direction = current_sort_direction
      @hoverable = hoverable
      @row_classes = row_classes
      @header = header
      @scroll = scroll
      @options = options
    end

    def pagination?
      pagination
    end

    def footer?
      columns.any?(&:footer)
    end

    def table_options
      { tag: 'table' }.deep_merge(@options).tap do |args|
        args[:classes] = merge_classes(
          DEFAULT_TABLE_CLASSES,
          'pulse:container pulse:mx-auto',
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
        'pulse:[&>tr:nth-child(even)]:bg-neutral-50': striped,
        'pulse:border-b pulse:[&>tr]:border-t pulse:[&>tr:first-child]:border-t-0': !striped # rubocop:disable Layout/LineLength
      )
    end

    def row_arguments(row)
      { tag: 'tr' }.tap do |args|
        args[:classes] = merge_classes(
          DEFAULT_ROW_CLASSES,
          { 'pulse:hover:bg-neutral-50': hoverable },
          row_classes
        )
        args[:id] = dom_id(row) if row.respond_to?(:to_key)
        args[:data] ||= {}
      end
    end

    def render_cell(**arguments, &)
      render(
        Pulse::Table::Cell.new(
          additional_params:,
          **arguments
        ),
        &
      )
    end
  end
end
