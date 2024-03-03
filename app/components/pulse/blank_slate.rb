# frozen_string_literal: true

module Pulse
  # Use as placeholder when content is missing
  class BlankSlate < Component
    renders_one :title
    renders_one :description
  end
end
