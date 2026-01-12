# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Popover, type: :component do
  it 'renders popover with default position and content' do
    render_inline(Pulse::Popover.new) do |c|
      c.with_heading { 'Pop heading' }
      c.with_body { 'Pop content' }
    end

    expect(page).to have_text('Pop heading')
    expect(page).to have_text('Pop content')
  end
end
