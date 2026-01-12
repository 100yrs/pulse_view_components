# frozen_string_literal: true

module Pulse
  class ButtonPreview < ViewComponent::Preview
    # @label Playground
    # The default is :primary style
    # @param label text
    # @param url url
    # @param scheme select {{ Pulse::Button::SCHEME_OPTIONS }}
    # @param size select {{ Pulse::Button::SIZE_OPTIONS }}
    # @param tag [Symbol] select [~, button]
    # @param button_to [Boolean] select [~, true, false]
    # @param disabled toggle
    def playground(
      label: 'Button',
      scheme: Pulse::Button::DEFAULT_SCHEME,
      size: Pulse::Button::DEFAULT_SIZE,
      url: '#',
      tag: :button,
      button_to: false,
      disabled: false
    )
      render(Pulse::Button.new(
               label:,
               scheme:,
               size:,
               url:,
               tag:,
               button_to:,
               disabled:
             ))
    end

    # @label Default
    # @param label text
    # @param size select {{ Pulse::Button::SIZE_OPTIONS }}
    # @param disabled toggle
    # @param tag select [a, summary, button]
    def default(
      label: 'Default',
      size: Pulse::Button::DEFAULT_SIZE,
      tag: :button,
      disabled: false
    )
      render(Pulse::Button.new(
               label:,
               size:,
               tag:,
               disabled:
             ))
    end

    # @label Primary
    # @param label text
    # @param size select {{ Pulse::Button::SIZE_OPTIONS }}
    # @param disabled toggle
    # @param tag select [a, summary, button]
    def primary(
      label: 'Primary',
      size: Pulse::Button::DEFAULT_SIZE,
      tag: :button,
      disabled: false
    )
      render(Pulse::Button.new(
               label:,
               scheme: :primary,
               size:,
               tag:,
               disabled:
             ))
    end

    # @label Secondary
    # @param label text
    # @param size select {{ Pulse::Button::SIZE_OPTIONS }}
    # @param disabled toggle
    # @param tag select [a, summary, button]
    def secondary(
      label: 'Secondary',
      size: Pulse::Button::DEFAULT_SIZE,
      tag: :button,
      disabled: false
    )
      render(Pulse::Button.new(
               label:,
               scheme: :secondary,
               size:,
               tag:,
               disabled:
             ))
    end

    # @label Danger
    # @param label text
    # @param size select {{ Pulse::Button::SIZE_OPTIONS }}
    # @param disabled toggle
    # @param tag select [a, summary, button]
    def danger(
      label: 'Danger',
      size: Pulse::Button::DEFAULT_SIZE,
      tag: :button,
      disabled: false
    )
      render(Pulse::Button.new(
               label:,
               scheme: :danger,
               size:,
               tag:,
               disabled:
             ))
    end

    # @label Button To
    # @param label text
    # @param url url
    # @param scheme select {{ Pulse::Button::SCHEME_OPTIONS }}
    # @param size select {{ Pulse::Button::SIZE_OPTIONS }}
    # @param disabled toggle
    def button_to(
      label: 'Button to',
      url: '#',
      scheme: Pulse::Button::DEFAULT_SCHEME,
      size: Pulse::Button::DEFAULT_SIZE,
      disabled: false
    )
      render(Pulse::Button.new(
               label:,
               url:,
               button_to: true,
               scheme:,
               size:,
               disabled:
             ))
    end
  end
end
