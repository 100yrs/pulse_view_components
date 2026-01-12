# frozen_string_literal: true

module Pulse
  # Renders a breadcrumb navigation list
  class Breadcrumbs < Pulse::Component
    renders_many :items, Pulse::BreadcrumbItem

    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :nav
    end

    def render?
      items.any?
    end
  end
end
