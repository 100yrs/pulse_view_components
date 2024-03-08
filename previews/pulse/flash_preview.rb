# frozen_string_literal: true

module Pulse
  # @label Flash
  class FlashPreview < ViewComponent::Preview
    # @label Playground
    #
    # # @param full toggle
    # # @param spacious toggle
    # # @param dismissible toggle
    # @param icon [Symbol] select [alert, check, info, people]
    # @param scheme [Symbol] select [default, warning, danger, success]
    # @param content text
    def playground(full: false, spacious: false, dismissible: false,
                   icon: :people, scheme: Pulse::Flash::DEFAULT_SCHEME,
                   content: 'This is a flash message!')
      render(Pulse::Flash.new(full: full, spacious: spacious,
                              dismissible: dismissible, icon: icon,
                              scheme: scheme)) do
        content
      end
    end

    # @label Default
    #
    def default
      render(Pulse::Flash.new) { 'This is a flash message!' }
    end

    # @!group Color Schemes
    #
    # @label Default
    def color_scheme_default
      render(Pulse::Flash.new) { 'This is a flash message!' }
    end

    # @label Warning
    def color_scheme_warning
      render(Pulse::Flash.new(scheme: :warning)) do
        'This is a warning flash message!'
      end
    end

    # @label Danger
    def color_scheme_danger
      render(Pulse::Flash.new(scheme: :danger)) do
        'This is a danger flash message!'
      end
    end

    # @label Success
    def color_scheme_success
      render(Pulse::Flash.new(scheme: :success)) do
        'This is a success flash message!'
      end
    end
    #
    # @!endgroup

    # @!group More options
    #
    # @label Full width
    # def options_full
    #   render(Pulse::Flash.new(full: true)) do
    #     'This is a full width flash message!'
    #   end
    # end

    # @label Dismissible
    # def options_dismissible
    #   render(Pulse::Flash.new(dismissible: true)) do
    #     'This is a dismissible flash message!'
    #   end
    # end

    # @label With icon
    def options_with_icon
      render(Pulse::Flash.new(icon: :alert)) do
        'This is a flash message with an icon!'
      end
    end
    #
    # @!endgroup
  end
end
