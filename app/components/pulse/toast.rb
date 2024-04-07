# frozen_string_literal: true

module Pulse
  # Renders a toast popup.
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
      default: 'pulse-bg-gray-700 pulse-text-white',
      error: 'pulse-bg-error-100 pulse-text-gray-900',
      success: 'pulse-bg-gray-700 pulse-text-white'
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
        # 'pulse-hidden',
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
          pulse__toast_auto_hide_value: @auto_hide,
          transition_enter: 'pulse-transition pulse-ease-out ' \
                            'pulse-duration-500',
          transition_enter_start: 'pulse-transform pulse-opacity-0 ' \
                                  'pulse-translate-y-full',
          transition_enter_end: 'pulse-transform pulse-opacity-100 ' \
                                'pulse-translate-y-0',
          transition_leave: 'pulse-transition pulse-ease-in pulse-duration-200',
          transition_leave_start: 'pulse-transform pulse-opacity-100',
          transition_leave_end: 'pulse-transform pulse-opacity-0'
        }
      )
    end

    def link_classes
      LINK_MAPPINGS[@theme]
    end
  end
end
