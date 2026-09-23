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

  it 'does not render the denylist as an attribute' do
    render_inline(
      Pulse::BaseComponent.new(
        tag: :div, system_arguments_denylist: { [:p] => 'Use padding.' }
      )
    )

    expect(page).to have_css('div')
      .and have_no_css('[system_arguments_denylist]')
  end

  it 'raises when a denied argument is given' do
    expect {
      Pulse::BaseComponent.new(
        tag: :div, p: 2,
        system_arguments_denylist: { [:p, :m] => 'Use padding.' }
      )
    }.to raise_error(ArgumentError, '`p` is an invalid argument. Use padding.')
  end

  it 'drops denied arguments when errors are disabled' do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with('PULSE_WARNINGS_DISABLED').and_return('1')

    render_inline(
      Pulse::BaseComponent.new(
        tag: :div, p: 2, id: 'box',
        system_arguments_denylist: { [:p, :m] => 'Use padding.' }
      )
    )

    expect(page).to have_css('div#box').and have_no_css('[p]')
  end
end
