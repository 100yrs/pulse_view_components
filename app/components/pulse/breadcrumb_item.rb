# frozen_string_literal: true

module Pulse
  # Renders a breadcrumb item
  class BreadcrumbItem < Pulse::Component
    DEFAULT_LINK_CLASSES = 'underline'
    DEFAULT_TEXT_CLASSES = ''

    attr_reader :text, :href

    def initialize(text:, href: nil, **system_arguments)
      super

      @text = text
      @href = href
      @classes = system_arguments[:classes]
      @system_arguments = system_arguments.except(:classes)
    end

    def link?
      @href.present?
    end

    def call
      if link?
        link_to(@text, @href, class: link_classes, **@system_arguments)
      else
        content_tag(:span, @text, class: text_classes, **@system_arguments)
      end
    end

    private

    def link_classes
      merge_classes(DEFAULT_LINK_CLASSES, @classes)
    end

    def text_classes
      merge_classes(DEFAULT_TEXT_CLASSES, @classes)
    end
  end
end
