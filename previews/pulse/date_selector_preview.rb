# frozen_string_literal: true

module Pulse
  class DateSelectorPreview < ViewComponent::Preview
    def default
      render(
        Pulse::DateSelector.new(
          start_date: (Date.current - 2.months).beginning_of_month,
          end_date: (Date.current - 1.month).end_of_month
        )
      )
    end
  end
end
