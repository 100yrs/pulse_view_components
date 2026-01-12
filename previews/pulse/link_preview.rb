# frozen_string_literal: true

module Pulse
  class LinkPreview < ViewComponent::Preview
    # @label Playground
    # @param href url
    # @param content text
    # @param scheme select {{ Pulse::Link::SCHEME_MAPPINGS.keys }}
    # @param bold toggle
    # @param underline toggle
    # @param condition toggle
    # @param classes text
    def playground(href: 'https://example.com', content: 'Link text',
                   scheme: Pulse::Link::DEFAULT_SCHEME,
                   bold: false, underline: true, condition: true, classes: '')
      render(
        Pulse::Link.new(href:, scheme:, bold:,
                        underline:, condition:,
                        classes:)
      ) do
        content
      end
    end

    # @label Default options
    def default
      render(Pulse::Link.new(href: 'https://example.com')) do
        'Link text'
      end
    end

    # @label Leading visual
    # @param href url
    # @param content text
    # @param scheme select {{ Pulse::Link::SCHEME_MAPPINGS.keys }}
    # @param bold toggle
    # @param underline toggle
    # @param classes text
    # @param icon text
    def leading_visual(href: 'https://example.com', content: 'Link text',
                       scheme: Pulse::Link::DEFAULT_SCHEME,
                       bold: false, underline: false, condition: true,
                       icon: 'gear', classes: '')
      render(
        Pulse::Link.new(href:, scheme:, bold:,
                        underline:, condition:,
                        classes:)
      ) do |c|
        c.with_leading_visual_icon(icon:)
        content
      end
    end
  end
end
