# frozen_string_literal: true

module Pulse
  # @label Badge
  class BadgePreview < ViewComponent::Preview
    # @label Playground
    #
    # @param tag select {{ Pulse::Badge::TAG_OPTIONS }}
    # @param scheme select {{ Pulse::Badge::SCHEME_OPTIONS }}
    # @param variant select {{ Pulse::Badge::VARIANT_OPTIONS }}
    def default(tag: :span, scheme: :secondary, variant: :standard)
      render(
        Pulse::Badge.new(tag: tag, scheme: scheme, variant: variant)
      ) do
        'Badge'
      end
    end

    # @label Primary
    def color_scheme_primary
      render(Pulse::Badge.new(scheme: :primary)) { 'Primary' }
    end

    # @label Secondary
    def color_scheme_secondary
      render(Pulse::Badge.new(scheme: :secondary)) { 'Secondary' }
    end

    # @label Secondary Outline
    def color_scheme_secondary_outline
      render(Pulse::Badge.new(scheme: :secondary_outline)) do
        'Secondary Outline'
      end
    end

    # @label Invited
    def color_scheme_success
      render(Pulse::Badge.new(scheme: :invited)) { 'Invited' }
    end

    # @label Active
    def color_scheme_hidden
      render(Pulse::Badge.new(scheme: :active)) { 'Active' }
    end

    # @label Disabled
    def color_scheme_failure
      render(Pulse::Badge.new(scheme: :disabled)) { 'Disabled' }
    end
  end
end
