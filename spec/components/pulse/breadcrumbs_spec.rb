# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Breadcrumbs, type: :component do
  it 'renders breadcrumbs' do
    component = render_inline(Pulse::Breadcrumbs.new) do |c|
      c.with_item(text: 'Home', href: '/')
      c.with_item(text: 'Current Page')
    end
    expect(component).to have_text('Home').and have_text('Current Page')
  end
end
