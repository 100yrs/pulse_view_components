# frozen_string_literal: true

module Pulse
  class ProfileImage < ViewComponent::Base
    delegate :render_svg, to: :helpers

    def initialize(user:)
      super

      @user = user
    end

    private

    attr_reader :user
  end
end
