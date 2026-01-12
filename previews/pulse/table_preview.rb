# frozen_string_literal: true

module Pulse
  # @label Table
  class TablePreview < ViewComponent::Preview
    COLLECTION = [
      { column1: 'A1', column2: 'A2', column3: 'A3' },
      { column1: 'B1', column2: 'B2', column3: 'B3' },
      { column1: 'C1', column2: 'C2', column3: 'C3' },
      { column1: 'D1', column2: 'D2', column3: 'D3' },
      { column1: 'E1', column2: 'E2', column3: 'E3' }
    ].freeze

    # @label Playground
    # def playground
    # end

    # @label Default options
    def default
      collection = ::Kaminari.paginate_array(COLLECTION).page(1).per(2)
      render(Pulse::Table.new(collection)) do |c|
        c.with_column(title: 'Column 1') do |row|
          row[:column1]
        end
        c.with_column(title: 'Column 2') do |row|
          row[:column2]
        end
        c.with_column do |row|
          row[:column3]
        end
      end
    end

    def striped
      render(Pulse::Table.new(COLLECTION, striped: true)) do |c|
        c.with_column(title: 'Column 1') do |row|
          row[:column1]
        end
        c.with_column(title: 'Column 2') do |row|
          row[:column2]
        end
        c.with_column do |row|
          row[:column3]
        end
      end
    end

    def hoverable
      render(Pulse::Table.new(COLLECTION, hoverable: true)) do |c|
        c.with_column(title: 'Column 1') do |row|
          row[:column1]
        end
        c.with_column(title: 'Column 2') do |row|
          row[:column2]
        end
        c.with_column do |row|
          row[:column3]
        end
      end
    end

    def without_header
      render(Pulse::Table.new(COLLECTION, header: false)) do |c|
        c.with_column do |row|
          row[:column1]
        end
        c.with_column do |row|
          row[:column2]
        end
        c.with_column do |row|
          row[:column3]
        end
      end
    end

    def custom_table_classes
      render(Pulse::Table.new(COLLECTION, classes: 'pulse-mt-4')) do |c|
        c.with_column(title: 'Column 1') do |row|
          row[:column1]
        end
        c.with_column(title: 'Column 2') do |row|
          row[:column2]
        end
        c.with_column do |row|
          row[:column3]
        end
      end
    end

    def custom_head_classes
      render(
        Pulse::Table.new(COLLECTION, head_classes: 'pulse-bg-secondary-100')
      ) do |c|
        c.with_column(title: 'Column 1') do |row|
          row[:column1]
        end
        c.with_column(title: 'Column 2') do |row|
          row[:column2]
        end
        c.with_column do |row|
          row[:column3]
        end
      end
    end

    def custom_row_classes
      render(
        Pulse::Table.new(COLLECTION, row_classes: 'pulse-bg-secondary-50')
      ) do |c|
        c.with_column(title: 'Column 1') do |row|
          row[:column1]
        end
        c.with_column(title: 'Column 2') do |row|
          row[:column2]
        end
        c.with_column do |row|
          row[:column3]
        end
      end
    end

    def custom_column_classes
      render(
        Pulse::Table.new(COLLECTION)
      ) do |c|
        c.with_column(title: 'Column 1',
                      classes: 'pulse-bg-secondary-50') do |row|
          row[:column1]
        end
        c.with_column(title: 'Column 2', classes: 'pulse-text-primary') do |row|
          row[:column2]
        end
        c.with_column(classes: 'pulse-font-bold') do |row|
          row[:column3]
        end
      end
    end

    def sortable
      render(Pulse::Table.new(COLLECTION, current_sort_column: 'c2',
                                          current_sort_direction: :desc)) do |c|
        c.with_column(title: 'Column 1', sort_by: 'c1') do |row|
          row[:column1]
        end
        c.with_column(title: 'Column 2', sort_by: 'c2') do |row|
          row[:column2]
        end
        c.with_column do |row|
          row[:column3]
        end
      end
    end

    def with_footers
      render(Pulse::Table.new(COLLECTION)) do |c|
        c.with_column(title: 'Column 1') do |row|
          row[:column1]
        end
        c.with_column(title: 'Column 2', footer: 'foot') do |row|
          row[:column2]
        end
        c.with_column(footer: 'total') do |row|
          row[:column3]
        end
      end
    end
  end
end
