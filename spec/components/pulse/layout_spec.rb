# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Layout, type: :component do
  context 'with sidebar and main' do
    it 'renders sidebar and main' do
      component = render_inline(Pulse::Layout.new) do |c|
        c.with_sidebar { 'Sidebar' }
        c.with_main { 'Main' }
      end
      expect(component).to have_text('Sidebar').and have_text('Main')
    end

    it 'keeps every grid class after merging' do
      render_inline(Pulse::Layout.new) do |c|
        c.with_sidebar { 'Sidebar' }
        c.with_main { 'Main' }
      end
      grid_classes = page.find('div', match: :first)[:class].split

      expect(grid_classes).to match_array(Pulse::Layout::GRID_CLASSES.split)
    end

    it 'gives the sidebar the layout sidebar width' do
      render_inline(Pulse::Layout.new) do |c|
        c.with_sidebar { 'Sidebar' }
        c.with_main { 'Main' }
      end

      expect(page).to have_css(
        '.pulse\\:col-1.pulse\\:w-\\(--pulse-layout-sidebar-width\\)',
        text: 'Sidebar'
      )
    end
  end

  # The scanner reads each Ruby string literal on its own, so a class split
  # across literals is missing from the build. See issue #30.
  it 'has a rule for every grid class in the built stylesheet' do
    css = File.read(
      File.expand_path(
        '../../../app/assets/builds/pulse_view_components.css', __dir__
      )
    )
    escaped = Pulse::Layout::GRID_CLASSES.split.map do |name|
      ".#{name.gsub(/[^a-zA-Z0-9_-]/) { |c| "\\#{c}" }}"
    end

    expect(escaped).to all(satisfy { |selector| css.include?(selector) })
  end

  # Both sidebar and main are required in order for the layout to render.
  context 'without sidebar or main' do
    it 'does not render' do
      layout = render_inline(Pulse::Layout.new) do |c|
        c.with_main { 'Main' }
      end
      expect(layout).to have_no_text('Main')
    end
  end
end
