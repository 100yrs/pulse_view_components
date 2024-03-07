# frozen_string_literal: true

module Pulse
  # Helpers for inline svg
  module SvgHelper
    # Render an embedded svg document
    # @param name [String] any filename present in the asset pipeline search paths
    # @param options [Hash] any additional options which `inline_svg_tag` accepts
    # @note Do not include the `.svg` suffix in the filename
    # @see https://github.com/jamesmartin/inline_svg#options Options documentation
    def render_svg(name, **options)
      if options[:title].blank?
        options[:aria_hidden] ||= true
        options[:aria] = nil
      else
        options[:aria] ||= true
      end
      options[:nocomment] ||= true
      options[:class] = class_names(
        options[:class],
        options[:classes]
      )

      filename = "#{name}.svg"
      inline_svg_tag(filename, **options)
    end
  end
end
