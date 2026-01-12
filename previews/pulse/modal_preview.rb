# frozen_string_literal: true

module Pulse
  # :nodoc:
  class ModalPreview < ViewComponent::Preview
    # @label Playground
    # @param title text
    # @param content text
    # @param size select {{ Pulse::Modal::SIZE_OPTIONS }}
    # @param close_button toggle
    # @param close_on_esc toggle
    # @param close_on_overlay_click toggle
    # @param close_on_submit toggle
    # @param auto_close toggle
    def playground(
      title: 'Modal title',
      content: 'Modal content',
      footer: 'Footer content',
      size: Pulse::Modal::DEFAULT_SIZE,
      close_button: true,
      close_on_esc: true,
      close_on_overlay_click: true,
      close_on_submit: true,
      auto_close: false
    )
      render Pulse::Modal.new(size:,
                              close_button:,
                              close_on_esc:,
                              close_on_overlay_click:,
                              close_on_submit:,
                              auto_close:) do |component|
        component.with_title { title }
        component.with_footer { footer }
        content
      end
    end

    # @label Default options
    # @param title text
    # @param content text
    def default(title: 'Modal title', content: 'Modal content')
      render Pulse::Modal.new do |component|
        component.with_title { title }
        content
      end
    end
  end
end
