# frozen_string_literal: true

module Pulse
  # Renders a modal component targetable by turbo frame
  class Modal < Pulse::Component
    include Turbo::FramesHelper

    renders_one :title
    renders_one :footer

    DEFAULT_SIZE = :md
    SIZE_MAPPINGS = {
      sm: 'pulse-max-w-md',
      md: 'pulse-max-w-2xl',
      lg: 'pulse-max-w-4xl',
      xl: 'pulse-max-w-5xl',
      xxl: 'pulse-max-w-6xl'
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys.freeze

    def initialize(size: DEFAULT_SIZE, close_button: true,
                   close_on_esc: true, close_on_overlay_click: true,
                   close_on_submit: true, auto_close: false, **system_arguments)
      super
      @size = fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)
      @system_arguments = system_arguments
      @modal_classes = merge_classes(
        'w-full',
        SIZE_MAPPINGS[@size],
        @system_arguments.delete(:classes)
      )
      @close_button = close_button
      @close_on_esc = close_on_esc
      @close_on_overlay_click = close_on_overlay_click
      @close_on_submit = close_on_submit
      @auto_close = auto_close

      @system_arguments[:'aria-labelledby'] = 'modal-title'
      @system_arguments[:'aria-modal'] = true
      @system_arguments[:classes] = 'pulse-fixed pulse-z-9999 pulse-inset-0 pulse-overflow-y-auto'
      @system_arguments[:data] = data_attributes
      @system_arguments[:role] = 'dialog'
      @system_arguments[:tabindex] = 0
      @system_arguments[:tag] = :div
    end

    private

    attr_reader :modal_classes, :close_button, :close_on_esc,
                :close_on_overlay_click, :close_on_submit, :auto_close

    def data_attributes
      merge_attributes(
        @system_arguments[:data],
        {
          controller: 'modal',
          'modal-close-on-esc-value': close_on_esc,
          'modal-close-on-submit-value': close_on_submit,
          'modal-auto-close-value': auto_close
        }
      )
    end
  end
end
