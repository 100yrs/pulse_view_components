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
      system_arguments[:classes] = class_names(system_arguments[:classes], 'flash-action')

      Pulse::BaseComponent.new(**system_arguments)
    }

    # TODO: Style icon in scheme color
    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      default: 'bg-[#ddf4ff] border border-[#54aeff]',
      warning: 'bg-[#fff8c5] border border-[#f6e05e]',
      danger: 'bg-[#ffebe9] border border-[#ff8182]',
      success: 'bg-[#dafbe1] border border-[#4ac26b]'
    }.freeze

    # @param full [Boolean] Whether the component should take up the full width of the screen.
    # @param spacious [Boolean] Whether to add margin to the bottom of the component.
    # @param dismissible [Boolean] Whether the component can be dismissed with an X button.
    # @param icon [Symbol] Name of Octicon icon to use.
    # @param scheme [Symbol] <%= one_of(Pulse::Flash::SCHEME_MAPPINGS.keys) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(full: false, spacious: false, dismissible: false,
                   icon: nil, scheme: DEFAULT_SCHEME, **system_arguments)
      super

      @icon = icon
      @dismissible = dismissible
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        'px-3 py-2 font-medium rounded-lg my-3 flex gap-2 items-center justify-start',

        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme,
                                          DEFAULT_SCHEME)],
        system_arguments[:classes],
        'flash-full': full
      )
      @system_arguments[:mb] ||= spacious ? 4 : nil
    end
  end
end
