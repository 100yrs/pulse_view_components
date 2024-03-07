# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::DateSelector, type: :component do
  let(:start_date) { Date.new(2023, 1, 1) }
  let(:end_date) { Date.new(2023, 1, 31) }

  it 'renders date heading' do
    with_request_url '/projects' do
      expect(
        render_inline(
          Pulse::DateSelector.new(start_date: start_date, end_date: end_date)
        )
      ).to have_css('h2', text: 'January 01, 2023 - January 31, 2023')
    end
  end
end
