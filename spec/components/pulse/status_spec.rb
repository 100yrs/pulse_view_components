# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::Status do
  it 'defaults new components to alpha' do
    expect(Class.new(Pulse::Component).status).to eq(:alpha)
  end

  it 'sets a status' do
    component = Class.new(Pulse::Component) { status :beta }

    expect(component.status).to eq(:beta)
  end

  it 'is inherited by subclasses' do
    expect(Pulse::NavList::Item.status).to eq(Pulse::ActionList::Item.status)
  end

  it 'does not leak a subclass status to its parent' do
    Class.new(Pulse::BorderBox) { status :stable }

    expect(Pulse::BorderBox.status).to eq(:beta)
  end

  it 'raises for an unknown status' do
    expect { Class.new(Pulse::Component) { status :experimental } }
      .to raise_error(ArgumentError, /Unknown status :experimental/)
  end

  # Lookbook shows the label, so non-stable components carry their status
  # there too. This keeps the label in step with the class.
  Rails.root.join('../previews/pulse').glob('*_preview.rb').each do |path|
    it "labels the #{path.basename('.rb')} with its component status" do
      component = "Pulse::#{path.basename('_preview.rb').to_s.camelize}"
      status = component.constantize.status
      label = path.read[/^  # @label (.+)$/, 1]
      suffix = label.to_s[/\((\w+)\)\z/, 1]

      expect(suffix).to eq(status == :stable ? nil : status.to_s)
    end
  end
end
