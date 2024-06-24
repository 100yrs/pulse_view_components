# frozen_string_literal: true

module Pulse
  # @label BlankSlate
  class BlankSlatePreview < ViewComponent::Preview
    # @label Default options
    def default
      render Pulse::BlankSlate.new do |component|
        component.with_title { 'Title' }
        component.with_description { 'Description' }
      end
    end
  end
end
