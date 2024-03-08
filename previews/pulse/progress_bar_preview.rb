# frozen_string_literal: true

module Pulse
  # @label ProgressBar
  class ProgressBarPreview < ViewComponent::Preview
    # @label Playground
    #
    # @display wrapper true
    # @display wrapper_classes 'flex justify-center items-center p-4 bg-gray-50 h-10 w-24'
    # @param percentage number
    # @param title text
    def playground(percentage: 50, title: nil)
      render Pulse::ProgressBar.new(percentage: percentage, title: title)
    end

    # @label Default
    #
    # @param percentage number
    def default(percentage: 50)
      render Pulse::ProgressBar.new(percentage: percentage)
    end
  end
end
