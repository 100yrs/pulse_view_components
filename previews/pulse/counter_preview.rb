# frozen_string_literal: true

module Pulse
  # @label Counter
  class CounterPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param count number
    # @param scheme select {{ Pulse::Counter::SCHEME_OPTIONS }}
    def playground(count: 10, scheme: :default)
      render Pulse::Counter.new(count:, scheme:)
    end
  end
end
