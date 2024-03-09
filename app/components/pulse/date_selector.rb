# frozen_string_literal: true

module Pulse
  # Renders a date selector component
  class DateSelector < Pulse::Component
    def initialize(start_date:, end_date:, **system_arguments)
      super

      @start_date = start_date
      @end_date = end_date
      @system_arguments = system_arguments
      @system_arguments[:classes] = merge_classes(
        system_arguments[:classes],
        'pulse-mb-6'
      )
    end

    def back_link_path
      url_for({
        start_date: (start_date - 1.month).beginning_of_month,
        end_date: (end_date - 1.month).end_of_month
      }.reverse_merge(page_params))
    end

    def forward_link_path
      url_for({
        start_date: (start_date + 1.month).beginning_of_month,
        end_date: (end_date + 1.month).end_of_month
      }.reverse_merge(page_params))
    end

    private

    def page_params
      @page_params ||= params.to_unsafe_h.except(:action, :controller, :_)
    end

    attr_reader :start_date, :end_date
  end
end
