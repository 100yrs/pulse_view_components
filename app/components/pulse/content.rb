# frozen_string_literal: true

module Pulse
  # Use `Content` as a helper to render content passed to a slot without adding
  # any tags.
  class Content < Component
    def call
      content
    end
  end
end
