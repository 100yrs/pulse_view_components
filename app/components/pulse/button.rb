# frozen_string_literal: true

module Pulse
  # Renders a button or link button
  class Button < Component
    delegate :button_to, to: :helpers

    DEFAULT_SCHEME = :secondary
    SCHEME_MAPPINGS = {
      primary: 'border border-solid border-gray-200 bg-green-700 text-white ' \
               'hover:bg-green-800 focus:bg-green-800 hover:text-white ' \
               'focus:text-white',
      secondary: 'border border-solid border-gray-200 bg-gray-50 text-gray ' \
                 'hover:bg-gray-100 focus:bg-gray-100',
      danger: 'border border-solid border-gray-200 bg-gray-50 ' \
              'text-danger-800 hover:bg-danger-800 focus:bg-danger-800 ' \
              'hover:text-white focus:text-white',
      link: 'appearance-none font-normal no-underline px-0 py-0 ' \
            'underline-offset-2 hover:underline focus:shadow-none'
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

    DEFAULT_SIZE = :md
    SIZE_MAPPINGS = {
      xs: 'text-xs leading-5 font-medium py-0.5 px-4',
      sm: 'text-sm font-medium py-1 px-5',
      md: 'text-base font-bold py-1.5 px-6'
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
        'appearance-none inline-flex justify-center rounded-md',
        'no-underline hover:no-underline',
        'focus:outline-none focus:no-underline',
        'disabled:opacity-25 disabled:cursor-not-allowed',
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
        button_to(label, url, options.merge(form_class: form_class))
      else
        button_to(url, options.merge(form_class: form_class)) { content }
      end
    end

    def call
      if button_to_helper
        raise(ArgumentError, 'URL is required') if url.blank?

        @options = options.merge(disabled: disabled) if disabled
        render_button_to
      elsif url.present?
        if disabled
          @options = options.merge(disabled: disabled) if disabled
          render_button
        else
          render_link
        end
      else
        @options = options.merge(disabled: disabled) if disabled
        render_button
      end
    end

    private

    attr_reader :kwargs, :label, :url, :tag, :button_to_helper,
                :disabled
  end
end
