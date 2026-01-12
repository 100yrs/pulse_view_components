# frozen_string_literal: true

module Pulse
  class NavLinkPreview < ViewComponent::Preview
    # @label Playground
    # @display bg_color "rgb(31 41 55)"
    # @param label text
    # @param path text
    # @param active_mode select [inclusive, exclusive]
    # @param variant select {{ Pulse::NavLink::VARIANT_OPTIONS }}
    def playground(label: 'Link', path: '#', active_mode: :inclusive,
                   variant: :desktop)
      render Pulse::NavLink.new(
        label:,
        path:,
        active_mode:,
        variant:
      )
    end

    # @label Active
    # @display bg_color "rgb(31 41 55)"
    # @param label text
    # @param variant select {{ Pulse::NavLink::VARIANT_OPTIONS }}
    def active(label: 'Link', variant: :desktop)
      render Pulse::NavLink.new(
        label:,
        path: '#',
        active_mode: :inclusive,
        variant:
      )
    end

    # @label Inactive
    # @display bg_color "rgb(31 41 55)"
    # @param label text
    # @param variant select {{ Pulse::NavLink::VARIANT_OPTIONS }}
    def inactive(label: 'Link', variant: :desktop)
      render Pulse::NavLink.new(
        label:,
        path: '/elsewhere',
        active_mode: :inclusive,
        variant:
      )
    end
  end
end
