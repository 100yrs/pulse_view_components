# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Modal, type: :component do
  it 'renders a modal' do
    expect(
      render_inline(Pulse::Modal.new)
    ).to have_css('[aria-modal="true"]')
  end

  it 'renders sm' do
    expect(
      render_inline(Pulse::Modal.new(size: :sm))
    ).to have_css("[class~='#{Pulse::Modal::SIZE_MAPPINGS[:sm]}']")
  end

  it 'renders md' do
    expect(
      render_inline(Pulse::Modal.new(size: :md))
    ).to have_css("[class~='#{Pulse::Modal::SIZE_MAPPINGS[:md]}']")
  end

  it 'renders lg' do
    expect(
      render_inline(Pulse::Modal.new(size: :lg))
    ).to have_css("[class~='#{Pulse::Modal::SIZE_MAPPINGS[:lg]}']")
  end

  it 'renders with close button' do
    expect(
      render_inline(Pulse::Modal.new(close_button: true))
    ).to have_css('[aria-label="Close Modal"]')
  end

  it 'renders without a close button' do
    expect(
      render_inline(Pulse::Modal.new(close_button: false))
    ).to have_no_css('[aria-label="Close Modal"]')
  end

  it 'renders a title' do
    expect(
      render_inline(Pulse::Modal.new) do |c|
        c.with_title { 'Title' }
      end
    ).to have_text('Title')
  end
end
