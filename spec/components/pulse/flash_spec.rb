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

  context 'with an action' do
    it 'renders the action after the message' do
      render_inline(Pulse::Flash.new) do |flash|
        flash.with_action { 'Undo' }
        'Item deleted'
      end

      expect(page).to have_css('div.flash-action', text: 'Undo')
      expect(page.text).to match(/Item deleted.*Undo/m)
    end

    it 'renders components passed to the action' do
      render_inline(Pulse::Flash.new) do |flash|
        flash.with_action do
          flash.render(Pulse::Button.new) { 'Undo' }
        end
        'Item deleted'
      end

      expect(page).to have_css('.flash-action button', text: 'Undo')
    end

    it 'merges classes and attributes onto the action' do
      render_inline(Pulse::Flash.new) do |flash|
        flash.with_action(classes: 'custom-action', id: 'flash-action') do
          'Undo'
        end
        'Item deleted'
      end

      expect(page).to have_css('div#flash-action.flash-action.custom-action')
    end

    it 'rejects a tag argument' do
      expect {
        render_inline(Pulse::Flash.new) do |flash|
          flash.with_action(tag: :span) { 'Undo' }
          'Item deleted'
        end
      }.to raise_error(ArgumentError, /`tag` is an invalid argument/)
    end
  end

  it 'renders no action wrapper without an action' do
    render_inline(Pulse::Flash.new) { 'Item deleted' }

    expect(page).to have_no_css('.flash-action')
  end
end
