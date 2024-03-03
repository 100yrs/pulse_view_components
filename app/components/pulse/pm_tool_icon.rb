# frozen_string_literal: true

module Pulse
  # Renders an icon for the project's PM tool
  class PmToolIcon < ViewComponent::Base
    def initialize(project:)
      super

      @project = project
    end

    def render?
      icon_name.present?
    end

    def call
      render Pulse::Icon.new(
        icon: icon_name,
        width: 16,
        height: 16,
        class: 'inline mb-1'
      )
    end

    private

    def icon_name
      case @project.pm_tool
      when 'zenhub'
        'mark-github'
      when 'jira'
        'mark-jira'
      end
    end
  end
end
