# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::BlankSlate, type: :component do
  it 'renders badge' do
    component = render_inline(Pulse::BlankSlate.new) do |c|
      c.with_title { 'Title' }
      c.with_description { 'Description' }
    end
    expect(component).to have_css(
      'p.pulse-text-lg', text: 'Title'
    ).and have_css(
      'p.pulse-text-base', text: 'Description'
    )
  end
end
