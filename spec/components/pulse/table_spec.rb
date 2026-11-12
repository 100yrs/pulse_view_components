# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Table, type: :component do
  let(:collection) do
    [
      { column1: 'A1', column2: 'A2', column3: 'A3' },
      { column1: 'B1', column2: 'B2', column3: 'B3' },
      { column1: 'C1', column2: 'C2', column3: 'C3' },
      { column1: 'D1', column2: 'D2', column3: 'D3' },
      { column1: 'E1', column2: 'E2', column3: 'E3' }
    ]
  end

  it 'renders table' do
    component = render_inline(Pulse::Table.new(collection)) do |c|
      c.with_column(title: 'Column 1') do |row|
        row[:column1]
      end
      c.with_column(title: 'Column 2') do |row|
        row[:column2]
      end
      c.with_column do |row|
        row[:column3]
      end
    end
    expect(component).to have_text('Column 1')
      .and have_text('A1')
      .and have_text('E3')
  end

  it 'gives rows neutral borders' do
    render_inline(Pulse::Table.new(collection)) do |c|
      c.with_column { |row| row[:column1] }
    end

    expect(page).to have_css('tbody > tr.pulse\:border-neutral-300', count: 5)
    expect(page).to have_no_css('tr.pulse\:border-secondary-300')
  end

  it 'lets row_classes override the border colour' do
    render_inline(
      Pulse::Table.new(collection, row_classes: 'pulse:border-primary-300')
    ) do |c|
      c.with_column { |row| row[:column1] }
    end

    expect(page).to have_css('tbody > tr.pulse\:border-primary-300', count: 5)
    expect(page).to have_no_css('tr.pulse\:border-neutral-300')
  end
end
