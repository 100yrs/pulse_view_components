# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Badge, type: :component do
  it 'displays badge with text' do
    expect(
      render_inline(Pulse::Badge.new) { 'Owner' }
    ).to have_text('Owner')
  end
end
