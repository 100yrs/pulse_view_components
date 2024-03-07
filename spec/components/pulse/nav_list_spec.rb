# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::NavList, type: :component do
  it 'renders navlist' do
    component = render_inline(Pulse::NavList.new) do |c|
      c.with_heading(title: 'Settings')

      c.with_item(label: 'Access', href: '#') do |item|
        item.with_leading_visual_icon(icon: :gear)
      end
    end
    expect(component).to have_text('Settings').and have_text('Access')
  end
end
