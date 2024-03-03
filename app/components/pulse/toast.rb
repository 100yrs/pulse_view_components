# frozen_string_literal: true

module Pulse
  # Renders a toast popup.
  # This is used in the Notice route for flash messages.
  class Toast < Component
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
      default: 'text-white hover:text-white',
      error: 'text-gray hover:text-gray',
      success: 'text-white hover:text-white'
    }.freeze

    THEME_MAPPINGS = {
      default: 'bg-gray text-white',
      error: 'bg-error-100 text-gray-900',
      success: 'bg-gray text-white'
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
        'hidden',
        'pl-8',
        'pr-4',
        'py-2.5',
        'mb-4',
        'rounded',
        'shadow-toast',
        'z-100',
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
