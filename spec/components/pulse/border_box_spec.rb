# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::BorderBox, type: :component do
  it 'renders border box' do
    component = render_inline(Pulse::BorderBox.new) do |c|
      c.with_row { 'Row 1 content' }
      c.with_row { 'Row 2 content' }
    end
    expect(component).to have_css(
      'li', text: 'Row 1 content'
    ).and have_css(
      'li', text: 'Row 2 content'
    )
  end

  it 'renders nothing without any slots' do
    render_inline(Pulse::BorderBox.new)

    expect(page).to have_no_css('div')
  end

  context 'with a header' do
    it 'renders header content' do
      render_inline(Pulse::BorderBox.new) do |c|
        c.with_header { 'Header content' }
      end

      expect(page).to have_css('div.Box-header', text: 'Header content')
    end

    it 'renders a header title with the given tag' do
      render_inline(Pulse::BorderBox.new) do |c|
        c.with_header do |header|
          header.with_title(tag: :h3) { 'Title' }
        end
      end

      expect(page).to have_css('.Box-header h3.Box-title', text: 'Title')
    end

    it 'raises for an unsupported title tag' do
      expect {
        render_inline(Pulse::BorderBox.new) do |c|
          c.with_header do |header|
            header.with_title(tag: :div) { 'Title' }
          end
        end
      }.to raise_error(Pulse::FetchOrFallbackHelper::InvalidValueError)
    end

    it 'labels the row list with the header' do
      render_inline(Pulse::BorderBox.new) do |c|
        c.with_header(id: 'box-header') { 'Header' }
        c.with_row { 'Row' }
      end

      expect(page).to have_css('#box-header', text: 'Header')
        .and have_css('ul[aria-labelledby="box-header"] li', text: 'Row')
    end

    it 'generates a header id when none is given' do
      render_inline(Pulse::BorderBox.new) do |c|
        c.with_header { 'Header' }
        c.with_row { 'Row' }
      end

      header_id = page.find('.Box-header')[:id]
      expect(header_id).to be_present
      expect(page).to have_css("ul[aria-labelledby='#{header_id}']")
    end

    it 'renders the header before the body, rows and footer' do
      render_inline(Pulse::BorderBox.new) do |c|
        c.with_footer { 'Footer' }
        c.with_row { 'Row' }
        c.with_body { 'Body' }
        c.with_header { 'Header' }
      end

      expect(page.text).to match(/Header.*Body.*Row.*Footer/m)
    end
  end

  it 'does not render the system arguments denylist' do
    render_inline(Pulse::BorderBox.new) { |c| c.with_body { 'Body' } }

    expect(page).to have_no_css('[system_arguments_denylist]')
  end

  it 'rejects padding system arguments' do
    expect {
      render_inline(Pulse::BorderBox.new(pt: 2)) { |c| c.with_body { 'Body' } }
    }.to raise_error(ArgumentError, /`pt` is an invalid argument.*:padding/)
  end

  it 'does not label the row list without a header' do
    render_inline(Pulse::BorderBox.new) { |c| c.with_row { 'Row' } }

    expect(page).to have_css('ul').and have_no_css('ul[aria-labelledby]')
  end
end
