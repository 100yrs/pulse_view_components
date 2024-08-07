# frozen_string_literal: true

module Pulse
  # Renders a button or link button
  class Button < Pulse::Component
    delegate :button_to, to: :helpers

    DEFAULT_SCHEME = :secondary
    SCHEME_MAPPINGS = {
      primary: 'pulse-border pulse-border-solid pulse-border-gray-300 ' \
               'pulse-bg-green-700 pulse-text-white hover:pulse-bg-green-800 ' \
               'focus-visible:pulse-bg-green-800 hover:pulse-text-white ' \
               'focus-visible:pulse-text-white ' \
               'focus-visible:pulse-shadow-btn-inset',
      secondary: 'pulse-border pulse-border-solid pulse-border-gray-300 ' \
                 'pulse-bg-gray-50 pulse-text-gray hover:pulse-bg-gray-100 ' \
                 'focus-visible:pulse-bg-gray-100',
      danger: 'pulse-border pulse-border-solid pulse-border-gray-300 ' \
              'pulse-bg-gray-50 pulse-text-danger-800 ' \
              'hover:pulse-bg-danger-800 focus-visible:pulse-bg-danger-800 ' \
              'hover:pulse-text-white focus-visible:pulse-text-white ' \
              'focus-visible:pulse-shadow-btn-inset'
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

    DEFAULT_SIZE = :md
    SIZE_MAPPINGS = {
      xs: 'pulse-text-xs pulse-leading-5 pulse-font-medium pulse-py-0.5 ' \
          'pulse-px-4',
      sm: 'pulse-text-sm pulse-font-medium pulse-py-1 pulse-px-5',
      md: 'pulse-text-base pulse-font-bold pulse-py-1.5 pulse-px-6'
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    def initialize(label: nil, scheme: DEFAULT_SCHEME, size: DEFAULT_SIZE,
                   url: nil, button_to: false, disabled: false, **kwargs)
      super

      @kwargs = kwargs
      @label = label
      @scheme = scheme
      @url = url
      @size = size
      @button_to_helper = button_to
      @disabled = disabled
      @tag = kwargs.fetch(:tag, :button)
    end

    def options
      @options ||= begin
        values = kwargs.except(:style, :tag, :label, :url, :size, :classes)

        if tag == :button && url.blank?
          # Default button to "type" to prevent the HTML5 default "submit"
          # behavior
          # See: https://stackoverflow.com/questions/932653/how-to-prevent-buttons-from-submitting-forms
          values = values.merge(type: kwargs.fetch(:type, 'button'))
        end

        values.merge(class: btn_class)
      end
    end

    def btn_class
      merge_classes(
        'pulse-appearance-none pulse-inline-flex pulse-justify-center',
        'pulse-rounded-md pulse-no-underline hover:pulse-no-underline',
        'focus-visible:pulse-no-underline',
        'focus-visible:-pulse-outline-offset-2',
        'focus-visible:pulse-outline-[2px] focus-visible:pulse-outline-solid',
        'focus-visible:pulse-outline-[var(--pulse-focus-outlineColor)]',
        'disabled:pulse-opacity-25 disabled:pulse-cursor-not-allowed',
        SIZE_MAPPINGS[@size],
        SCHEME_MAPPINGS[@scheme],
        kwargs.fetch(:classes, '')
      )
    end

    def render_link
      if label.present?
        link_to(label, url, options)
      else
        link_to(url, options) { content }
      end
    end

    def render_button
      if label.present?
        content_tag(tag, label, options)
      else
        content_tag(tag, options) { content }
      end
    end

    def render_button_to
      form_class = options[:form_class] || 'contents'

      if label.present?
        button_to(label, url, options.merge(form_class:))
      else
        button_to(url, options.merge(form_class:)) { content }
      end
    end

    def call
      if button_to_helper
        raise(ArgumentError, 'URL is required') if url.blank?

        @options = options.merge(disabled:) if disabled
        render_button_to
      elsif url.present?
        if disabled
          @options = options.merge(disabled:) if disabled
          render_button
        else
          render_link
        end
      else
        @options = options.merge(disabled:) if disabled
        render_button
      end
    end

    private

    attr_reader :kwargs, :label, :url, :tag, :button_to_helper,
                :disabled
  end
end
