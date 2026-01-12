# frozen_string_literal: true

module Pulse
  # Use `Flash` to inform users of successful or pending actions.
  class Flash < Pulse::Component
    # Optional action content showed on the right side of the component.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :action, lambda { |**system_arguments|
      deny_tag_argument(**system_arguments)
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        system_arguments[:classes],
        'flash-action'
      )

      Pulse::BaseComponent.new(**system_arguments)
    }

    # TODO: Style icon in scheme color
    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      default: 'pulse-bg-[#ddf4ff] pulse-border pulse-border-[#54aeff]',
      warning: 'pulse-bg-[#fff8c5] pulse-border pulse-border-[#f6e05e]',
      danger: 'pulse-bg-[#ffebe9] pulse-border pulse-border-[#ff8182]',
      success: 'pulse-bg-[#dafbe1] pulse-border pulse-border-[#4ac26b]'
    }.freeze

    # @param full [Boolean] Whether the component should take up the full width of the screen.
    # @param spacious [Boolean] Whether to add margin to the bottom of the component.
    # @param dismissible [Boolean] Whether the component can be dismissed with an X button.
    # @param icon [Symbol] Name of Octicon icon to use.
    # @param scheme [Symbol] <%= one_of(Pulse::Flash::SCHEME_MAPPINGS.keys) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(full: false, spacious: false, dismissible: false,
                   icon: nil, scheme: DEFAULT_SCHEME, **system_arguments)
      @icon = icon
      @dismissible = dismissible
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        'pulse-px-3 pulse-py-2 pulse-font-medium pulse-rounded-lg pulse-my-3',
        'pulse-flex pulse-gap-2 pulse-items-center pulse-justify-start',
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme,
                                          DEFAULT_SCHEME)],
        system_arguments[:classes],
        'flash-full': full
      )
      @system_arguments[:mb] ||= spacious ? 4 : nil
    end
  end
end
