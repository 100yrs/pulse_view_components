# frozen_string_literal: true

module Foundations
  # Reads the token stylesheets rather than the built CSS, because Tailwind
  # only emits the theme variables that some class uses.
  #
  # @label Colors
  class ColorsPreview < ViewComponent::Preview
    Swatch = Data.define(:shade, :hex) do
      # Dark text on light swatches, using relative luminance.
      def ink
        r, g, b = hex.delete('#').scan(/../).map { it.to_i(16) / 255.0 }
        luminance = (0.2126 * r) + (0.7152 * g) + (0.0722 * b)
        luminance > 0.55 ? '#111827' : '#ffffff'
      end
    end

    TOKENS_PATH = Pulse::ViewComponents::Engine.root.join(
      'app/assets/stylesheets/pulse_view_components'
    )
    PALETTE_PATTERN = /--palette-([a-z-]+)-(\d+):\s*(#\h{6});/
    SEMANTIC_PATTERN = /--color-([a-z]+):\s*--theme\(--palette-([a-z-]+)-(\d+)/

    # @label Semantic
    def semantic
      render_with_template(
        locals: { semantic: semantic_tokens, palettes: palette_tokens }
      )
    end

    # @label Palettes
    def palettes
      render_with_template(locals: { palettes: palette_tokens })
    end

    private

    # { 'coral-red' => [Swatch('50', '#ffecec'), ...], ... }
    def palette_tokens
      TOKENS_PATH.join('tokens.primitives.css').read
                 .scan(PALETTE_PATTERN)
                 .group_by(&:first)
                 .transform_values do |rows|
                   rows.map { |_, shade, hex| Swatch.new(shade:, hex:) }
                 end
    end

    # { 'primary' => ['coral-red', '700'], ... }
    def semantic_tokens
      TOKENS_PATH.join('tokens.system.css').read
                 .scan(SEMANTIC_PATTERN)
                 .to_h { |name, palette, shade| [name, [palette, shade]] }
    end
  end
end
