# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::NavLink, type: :component do
  context 'when desktop' do
    it 'renders navlink' do
      component = render_inline(
        Pulse::NavLink.new(label: 'Dashboard', path: '/')
      )
      expect(component).to have_link('Dashboard', href: '/')
    end
  end

  context 'when mobile' do
    it 'renders navlink' do
      component = render_inline(
        Pulse::NavLink.new(label: 'Dashboard', path: '/', mobile: true)
      )
      expect(component).to have_link('Dashboard', href: '/')
    end
  end
end
