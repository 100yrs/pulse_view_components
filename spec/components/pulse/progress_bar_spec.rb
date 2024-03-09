# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::ProgressBar, type: :component do
  context 'when percentage is 100 or less' do
    it 'renders a progress bar with the given percentage' do
      component = render_inline(Pulse::ProgressBar.new(percentage: 50))

      expect(component).to have_css('.pulse-bg-success', style: 'width: 50%')
    end
  end

  context 'when percentage is over 100' do
    it 'renders a progress bar with overage' do
      component = render_inline(Pulse::ProgressBar.new(percentage: 110))

      expect(component).to have_css('.pulse-bg-error', style: 'width: 10%')
    end
  end
end
