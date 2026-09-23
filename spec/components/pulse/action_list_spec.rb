# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::ActionList, type: :component do
  it 'renders items in a list' do
    render_inline(Pulse::ActionList.new) do |list|
      list.with_item(label: 'First', href: '#')
      list.with_item(label: 'Second', href: '#')
    end

    expect(page).to have_css('ul[role="list"] li', count: 2)
      .and have_css('li a', text: 'First')
      .and have_css('li a', text: 'Second')
  end

  it 'renders dividers between items when show_dividers is set' do
    render_inline(Pulse::ActionList.new(show_dividers: true)) do |list|
      list.with_item(label: 'First', href: '#')
      list.with_item(label: 'Second', href: '#')
    end

    expect(page).to have_css('li[role="presentation"]', count: 1)
  end

  context 'with a heading' do
    it 'renders the title in an h3 by default' do
      render_inline(Pulse::ActionList.new) do |list|
        list.with_heading(title: 'Favourites')
        list.with_item(label: 'Item', href: '#')
      end

      expect(page).to have_css('.ActionList-sectionDivider h3',
                               text: 'Favourites')
    end

    it 'renders the title at the given heading level' do
      render_inline(Pulse::ActionList.new) do |list|
        list.with_heading(title: 'Favourites', heading_level: 2)
        list.with_item(label: 'Item', href: '#')
      end

      expect(page).to have_css('h2', text: 'Favourites')
        .and have_no_css('h3')
    end

    it 'renders the heading outside the list' do
      render_inline(Pulse::ActionList.new) do |list|
        list.with_heading(title: 'Favourites')
        list.with_item(label: 'Item', href: '#')
      end

      expect(page).to have_no_css('ul h3')
    end

    it 'labels the list with the heading title' do
      render_inline(Pulse::ActionList.new) do |list|
        list.with_heading(title: 'Favourites')
        list.with_item(label: 'Item', href: '#')
      end

      title_id = page.find('h3')[:id]
      expect(title_id).to be_present
      expect(page).to have_css("ul[aria-labelledby='#{title_id}']")
        .and have_no_css('ul[aria-describedby]')
    end

    it 'describes the list with the subtitle' do
      render_inline(Pulse::ActionList.new) do |list|
        list.with_heading(title: 'Favourites', subtitle: 'Pinned items')
        list.with_item(label: 'Item', href: '#')
      end

      subtitle_id = page.find('span', text: 'Pinned items')[:id]
      expect(subtitle_id).to be_present
      expect(page).to have_css("ul[aria-describedby='#{subtitle_id}']")
    end

    it 'applies the filled scheme' do
      render_inline(Pulse::ActionList.new) do |list|
        list.with_heading(title: 'Favourites', scheme: :filled)
        list.with_item(label: 'Item', href: '#')
      end

      expect(page).to have_css('.ActionList-sectionDivider--filled')
    end

    it 'raises for a heading level outside 1 to 6' do
      expect {
        render_inline(Pulse::ActionList.new) do |list|
          list.with_heading(title: 'Favourites', heading_level: 7)
        end
      }.to raise_error(RuntimeError, /Heading level must be between 1 and 6/)
    end

    it 'rejects a tag argument' do
      expect {
        render_inline(Pulse::ActionList.new) do |list|
          list.with_heading(title: 'Favourites', tag: :p)
        end
      }.to raise_error(ArgumentError, /`tag` is an invalid argument/)
    end
  end
end
