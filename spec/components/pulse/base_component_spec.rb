# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::BaseComponent, type: :component do
  it 'renders an html tag with content' do
    expect(
      render_inline(
        Pulse::BaseComponent.new(tag: :span, classes: 'text-sm')
      ) do
        'Hello, world!'
      end
    ).to have_css('span.text-sm', text: 'Hello, world!')
  end
end
