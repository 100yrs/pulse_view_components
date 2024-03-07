# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Link, type: :component do
  it 'renders a link' do
    expect(
      render_inline(Pulse::Link.new(href: 'https://example.com')) do
        'Link text'
      end
    ).to have_link('Link text', href: 'https://example.com')
  end

  context 'with leading visual' do
    it 'renders a link and icon' do
      expect(
        render_inline(Pulse::Link.new(href: 'https://example.com')) do |c|
          c.with_leading_visual_icon(name: 'edit')
          'Link text'
        end
      ).to have_link('Link text', href: 'https://example.com')
        .and have_css('svg')
    end
  end

  context 'with false condition' do
    it 'renders a span' do
      expect(
        render_inline(Pulse::Link.new(href: 'https://example.com',
                                      condition: false)) do
          'Link text'
        end
      ).to have_css('span')
    end
  end
end
