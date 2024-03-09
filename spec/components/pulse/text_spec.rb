# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Text, type: :component do
  it 'renders text' do
    component = render_inline(Pulse::Text.new(type: :body1)) { 'Text' }
    expect(component).to have_css('p.pulse-text-lg', text: 'Text')
  end
end
