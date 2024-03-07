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
end
