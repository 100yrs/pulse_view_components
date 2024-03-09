# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Button, type: :component do
  it 'renders button' do
    component = render_inline(Pulse::Button.new(label: 'button text'))
    expect(component).to have_button('button text')
  end

  context 'with scheme' do
    it 'renders button with scheme' do
      component =
        render_inline(Pulse::Button.new(label: 'button text', scheme: :danger))
      expect(
        component
      ).to have_button('button text').and have_css('.pulse-text-danger-800')
    end
  end

  context 'with size' do
    it 'renders button with size' do
      component =
        render_inline(Pulse::Button.new(label: 'button text', size: :sm))
      expect(
        component
      ).to have_button('button text').and have_css('.pulse-text-sm')
    end
  end

  context 'with type' do
    it 'renders button of type' do
      component =
        render_inline(Pulse::Button.new(label: 'button text', type: :submit))
      expect(
        component
      ).to have_button('button text').and have_css('[type="submit"]')
    end
  end

  context 'with url' do
    it 'renders link' do
      component = render_inline(
        Pulse::Button.new(
          label: 'button link text',
          url: '/somewhere'
        )
      )
      expect(component).to have_link('button link text', href: '/somewhere')
    end

    context 'with button_to' do
      it 'renders button_to form' do
        component = render_inline(
          Pulse::Button.new(
            label: 'button text',
            url: '/somewhere',
            button_to: true,
            method: :delete
          )
        )
        expect(
          component
        ).to have_css('form[method="post"]').and have_css(
          'input[type="hidden"][name="_method"][value="delete"]',
          visible: :hidden
        ).and have_button('button text')
      end
    end
  end
end
