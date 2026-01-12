# frozen_string_literal: true

module Pulse
  # :nodoc:
  class IconPreview < ViewComponent::Preview
    # @label Playground
    # @param icon [Symbol] select [alert, bookmark-slash, bookmark, check, close, dots-outline, gear, info, issue, mark-github, mark-jira, people, ruby, sort_asc, sort_desc, three-bars]
    def playground(icon: :info)
      render(Pulse::Icon.new(icon:))
    end
  end
end
