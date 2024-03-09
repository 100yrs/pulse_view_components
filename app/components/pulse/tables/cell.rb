# frozen_string_literal: true

module Pulse
  module Tables
    # Renders a table cell
    class Cell < Pulse::Component
      attr_reader :sort_by, :current_sort_column, :current_sort_direction,
                  :additional_params, :footer

      HEAD_DEFAULT_SCHEME = :xs
      HEAD_SCHEME_MAPPINGS = {
        sm: 'pulse-px-3 pulse-py-4 print:pulse-px-2 print:pulse-py-3 pulse-text-sm print:pulse-text-xs pulse-font-base',
        xs: 'pulse-px-2 pulse-py-4 print:pulse-py-2 pulse-text-xs print:pulse-text-2xs pulse-font-medium'
      }.freeze
      HEAD_SCHEME_OPTIONS = HEAD_SCHEME_MAPPINGS.keys.freeze

      DEFAULT_CELL_CLASSES = 'pulse-text-start first:pulse-ps-4 last:pulse-pe-4 pulse-px-2 pulse-text-gray' \
                             'print:pulse-first-ps-2 print:pulse-last-pe-2'
      DEFAULT_TH_CLASSES = 'pulse-uppercase pulse-tracking-wider'
      DEFAULT_TD_CLASSES = 'pulse-py-2 pulse-whitespace-nowrap ' \
                           'pulse-text-sm print:pulse-text-xs pulse-text-gray'

      def initialize(sort_by: nil, current_sort_column: nil,
                     current_sort_direction: nil, additional_params: {},
                     head_scheme: HEAD_DEFAULT_SCHEME, footer: nil,
                     title_classes: '', **options)
        super

        @sort_by = sort_by
        @current_sort_column = current_sort_column
        @current_sort_direction = current_sort_direction
        @additional_params = additional_params
        @footer = footer
        @title_classes = title_classes
        @options = options
        @options[:classes] = merge_classes(
          DEFAULT_CELL_CLASSES,
          header_or_footer? ? DEFAULT_TH_CLASSES : DEFAULT_TD_CLASSES,
          header_or_footer? ? HEAD_SCHEME_MAPPINGS[head_scheme] : '',
          options[:classes]
        )
      end

      def options
        { tag: 'td' }.deep_merge(@options).tap do |args|
          args[:classes] = class_names(
            args[:classes]
          )
        end
      end

      def title_classes
        header_or_footer? ? @title_classes : ''
      end

      def active
        sort_by && sort_by == current_sort_column
      end

      def sortable?
        sort_by && params[:q].blank?
      end

      def dir
        current_sort_direction
      end

      def icon
        active ? "sort_#{dir}" : 'sort'
      end

      def header_or_footer?
        @options[:tag] == 'th' || @footer
      end

      def url_options
        { sort: sort_by, direction: direction }.merge(additional_params)
      end

      def direction
        params[:sort].nil? || params[:sort] == sort_by ? sort_dir : nil
      end

      def sort_dir
        params[:direction] == 'asc' ? 'desc' : 'asc'
      end
    end
  end
end
