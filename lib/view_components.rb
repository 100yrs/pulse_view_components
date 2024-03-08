# frozen_string_literal: true

# require "primer/classify"
require "pulse/view_components/version"
require "pulse/view_components/engine"

module Pulse
  # :nodoc:
  module ViewComponents
    # pulse/view_components root directory.
    def self.root
      Pathname(File.expand_path(File.join("..", ".."), __dir__))
    end
  end
end