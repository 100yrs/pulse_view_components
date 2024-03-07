# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Label, type: :component do
  it 'renders label with title' do
    expect(
      render_inline(Pulse::Label.new(title: 'title'))
    ).to have_text('title')
  end
end
