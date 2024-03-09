# frozen_string_literal: true

module Pulse
  # Renders a toast popup.
  # This is used in the Notice route for flash messages.
  class Toast < Pulse::Component
    include Turbo::FramesHelper

    renders_one :action, lambda { |url:, **system_arguments, &block|
      system_arguments[:tag] = :a
      system_arguments[:href] = url
      system_arguments[:classes] = merge_classes(
        system_arguments[:classes],
        LINK_MAPPINGS[@theme]
      )
      BaseComponent.new(**system_arguments, &block)
    }

    LINK_MAPPINGS = {
      default: 'pulse-text-white hover:pulse-text-white',
      error: 'pulse-text-gray hover:pulse-text-gray',
      success: 'pulse-text-white hover:pulse-text-white'
    }.freeze

    THEME_MAPPINGS = {
      default: 'pulse-bg-gray pulse-text-white',
      error: 'pulse-bg-error-100 pulse-text-gray-900',
      success: 'pulse-bg-gray pulse-text-white'
    }.freeze
    DEFAULT_THEME = :default

    def initialize(
      auto_hide: true,
      theme: DEFAULT_THEME,
      **system_arguments
    )
      super
      @auto_hide = auto_hide
      @system_arguments = system_arguments
      @theme = theme

      @system_arguments[:tag] ||= :div
      @system_arguments[:data] = data_attributes
      @system_arguments[:classes] = class_attributes
    end

    private

    def class_attributes
      merge_classes(
        @system_arguments[:classes],
        'pulse-hidden',
        'pulse-pl-8',
        'pulse-pr-4',
        'pulse-py-2.5',
        'pulse-mb-4',
        'pulse-rounded',
        'pulse-shadow-toast',
        'pulse-z-100',
        THEME_MAPPINGS[@theme]
      )
    end

    def data_attributes
      merge_attributes(
        @system_arguments[:data],
        {
          controller: 'pulse--toast',
          ui__toast_auto_hide_value: @auto_hide,
          transition_enter: 'transition ease-out duration-500',
          transition_enter_start: 'transform opacity-0 translate-y-full',
          transition_enter_end: 'transform opacity-100 translate-y-0',
          transition_leave: 'transition ease-in duration-200',
          transition_leave_start: 'transform opacity-100',
          transition_leave_end: 'transform opacity-0'
        }
      )
    end

    def link_classes
      LINK_MAPPINGS[@theme]
    end
  end
end
