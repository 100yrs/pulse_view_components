# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Popover, type: :component do
  it 'renders popover with default position and content' do
    render_inline(Pulse::Popover.new) do |c|
      c.with_heading { 'Pop heading' }
      c.with_body { 'Pop content' }
    end

    expect(page).to have_text('Pop heading')
    expect(page).to have_text('Pop content')
  end

  it 'draws the caret on the side the caret option names' do
    render_inline(Pulse::Popover.new) do |c|
      c.with_body(caret: :left_top) { 'Pop content' }
    end

    expect(page).to have_css(
      '[data-caret="left_top"].pulse\\:relative.pulse\\:ml-2' \
      '.pulse\\:before\\:-left-1\\.5.pulse\\:before\\:top-6'
    )
    expect(page).to have_no_css('[data-caret].pulse\\:mt-2')
  end

  it 'widens the wrapper when large' do
    render_inline(Pulse::Popover.new) do |c|
      c.with_body(large: true) { 'Pop content' }
    end

    expect(page).to have_css('div.pulse\\:w-80 > [data-caret]')
    expect(page).to have_no_css('.pulse\\:w-64')
  end

  it 'lets caller classes override the body defaults' do
    render_inline(Pulse::Popover.new) do |c|
      c.with_body(classes: 'pulse:p-2') { 'Pop content' }
    end

    expect(page).to have_css('[data-caret].pulse\\:p-2')
    expect(page).to have_no_css('[data-caret].pulse\\:p-4')
  end
end
