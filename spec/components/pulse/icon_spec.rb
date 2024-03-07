# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Icon, type: :component do
  it 'renders an icon' do
    icon = render_inline(Pulse::Icon.new(icon: 'close'))

    expect(icon).to have_css('svg')
  end

  it 'defaults to small size' do
    icon = render_inline(Pulse::Icon.new(icon: 'close'))

    expect(icon).to have_css('svg[height="16"]')
  end

  context 'with size' do
    it 'sets size' do
      icon = render_inline(Pulse::Icon.new(icon: 'close', size: :md))

      expect(icon).to have_css('svg[height="24"]')
    end
  end
end
