# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Forms::ErrorExplanation, type: :component do
  let(:resource) { Project.new }

  let(:component) do
    render_inline(
      Pulse::Forms::ErrorExplanation.new(resource:)
    )
  end

  before do
    resource.valid?
  end

  it 'renders errors' do
    expect(component).to have_text('Title can\'t be blank')
  end

  it 'renders a heading with the error count' do
    expect(component).to have_css(
      'h2', text: '1 error prohibited this project from being saved:'
    )
  end

  it 'uses the app header translation when one is defined' do
    I18n.backend.store_translations(
      :en, errors: { template: { header: { one: 'One problem' } } }
    )

    expect(component).to have_css('h2', text: 'One problem')
  ensure
    I18n.backend.reload!
  end

  context 'with a locale the component does not translate' do
    around do |example|
      helper = ActionView::Helpers::TranslationHelper
      raise_on_missing = helper.raise_on_missing_translations
      available_locales = I18n.available_locales
      helper.raise_on_missing_translations = true
      I18n.available_locales += [:fr]

      I18n.with_locale(:fr) { example.run }
    ensure
      helper.raise_on_missing_translations = raise_on_missing
      I18n.available_locales = available_locales
      I18n.backend.reload!
    end

    it 'uses the app header translation without raising' do
      I18n.backend.store_translations(
        :fr, errors: { template: { header: { one: 'Une erreur' } } }
      )

      expect(component).to have_css('h2', text: 'Une erreur')
    end

    it 'falls back to the English header without an app translation' do
      expect(component).to have_css(
        'h2', text: '1 error prohibited this project from being saved:'
      )
    end
  end

  it 'lists each attribute once' do
    resource.errors.add(:title, 'is too short')

    expect(component).to have_css('li', text: 'Title is too short')
      .and have_no_css('li', text: "Title can't be blank")
  end

  it 'counts each attribute once in the heading' do
    resource.errors.add(:title, 'is too short')

    expect(component).to have_css(
      'h2', text: '1 error prohibited this project from being saved:'
    )
  end

  it 'merges classes and attributes' do
    render_inline(
      Pulse::Forms::ErrorExplanation.new(resource:, classes: 'pulse:my-0',
                                         id: 'errors')
    )

    expect(page).to have_css('div#errors.pulse\\:my-0')
      .and have_no_css('.pulse\\:my-3')
  end

  it 'rejects a tag argument' do
    expect {
      Pulse::Forms::ErrorExplanation.new(resource:, tag: :section)
    }.to raise_error(ArgumentError, /`tag` is an invalid argument/)
  end

  it 'renders nothing without errors' do
    resource.errors.clear

    expect(component.to_html).to be_empty
  end
end
