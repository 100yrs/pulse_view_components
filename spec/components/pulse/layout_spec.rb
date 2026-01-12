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
