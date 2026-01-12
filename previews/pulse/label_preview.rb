# frozen_string_literal: true

module Pulse
  # :nodoc:
  class LabelPreview < ViewComponent::Preview
    def default
      render(Pulse::Label.new(title: 'A label'))
    end
  end
end
