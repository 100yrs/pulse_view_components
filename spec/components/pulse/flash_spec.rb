# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Flash, type: :component do
  it 'renders flash message' do
    flash = render_inline(Pulse::Flash.new) { 'This is a flash message!' }

    expect(flash).to have_text('This is a flash message!')
  end

  it 'renders flash message with icon' do
    flash = render_inline(Pulse::Flash.new(icon: :alert)) { 'Alert message' }

    expect(flash).to have_css('svg')
  end
end
