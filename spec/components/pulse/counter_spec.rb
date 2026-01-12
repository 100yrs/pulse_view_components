# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Counter, type: :component do
  it 'displays badge with text' do
    expect(render_inline(Pulse::Counter.new(count: 10))).to have_text('10')
  end
end
