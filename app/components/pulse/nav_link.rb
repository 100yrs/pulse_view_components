# frozen_string_literal: true

module Pulse
  # Links in navbars
  class NavLink < Component
    def initialize(label:, path:, active_mode: :inclusive, mobile: false,
                   **system_arguments)
      super

      @label = label
      @path = path
      @active_mode = active_mode
      @mobile = mobile
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div
    end

    private

    attr_reader :label, :path, :active_mode, :mobile
  end
end
