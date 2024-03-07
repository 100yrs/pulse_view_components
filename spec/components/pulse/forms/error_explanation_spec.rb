# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Forms::ErrorExplanation, type: :component do
  let(:resource) { Project.new }

  let(:component) do
    render_inline(
      Pulse::Forms::ErrorExplanation.new(resource: resource)
    )
  end

  before do
    resource.valid?
  end

  it 'renders errors' do
    expect(component).to have_text('Title can\'t be blank')
  end
end
