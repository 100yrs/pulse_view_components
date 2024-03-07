# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Toast, type: :component do
  context 'with default options' do
    it 'renders toast' do
      component = render_inline(Pulse::Toast.new) { 'Woohoo toast!' }

      expect(
        component
      ).to have_css('div', text: 'Woohoo toast!').and have_css('svg')
    end
  end

  context 'with action' do
    it 'renders toast with action link' do
      component = render_inline(Pulse::Toast.new) do |c|
        c.with_action(url: 'https://example.com') { 'link' }
        'Woohoo toast!'
      end

      expect(
        component
      ).to have_css(
        'div', text: 'Woohoo toast!'
      ).and have_css(
        'svg'
      ).and have_css(
        'a', text: 'link'
      )
    end
  end
end
