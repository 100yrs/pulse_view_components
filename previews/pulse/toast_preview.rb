# frozen_string_literal: true

module Pulse
  class ToastPreview < ViewComponent::Preview
    # @label Playground
    # @param theme [Symbol] select [[Default, ~], [Error, error], [Success, success]]
    # @param auto_hide toggle
    # @param text text
    def default(auto_hide: true, theme: :default, text: 'This is a default toast.')
      render Pulse::Toast.new(auto_hide: auto_hide, theme: theme) do |c|
        c.with_action(url: 'https://www.jamieoliver.com/recipes/category/course/snacks/') do
          'Undo'
        end
        text
      end
    end

    # @label Default
    def default_theme
      render Pulse::Toast.new do |c|
        c.with_action(url: 'https://www.jamieoliver.com/recipes/category/course/snacks/') do
          'Undo'
        end
        'This is a default toast.'
      end
    end

    def error
      render Pulse::Toast.new(theme: :error) do |c|
        c.with_action(url: 'https://www.jamieoliver.com/recipes/category/course/snacks/') do
          'Undo'
        end
        'This is an error toast.'
      end
    end

    def success
      render Pulse::Toast.new(theme: :success) do |c|
        c.with_action(url: 'https://www.jamieoliver.com/recipes/category/course/snacks/') do
          'Undo'
        end
        'This is a success toast.'
      end
    end

    def auto_hide_off
      render Pulse::Toast.new(auto_hide: false) do |c|
        c.with_action(url: 'https://www.jamieoliver.com/recipes/category/course/snacks/') do
          'Undo'
        end
        'This is a toast message.'
      end
    end

    def long_text
      render Pulse::Toast.new do |c|
        c.with_action(url: 'https://www.jamieoliver.com/recipes/category/course/snacks/') do
          'Undo'
        end
        'Blanditiis ut autem nesciunt ex sunt similique tempora et enim dolorum ' \
          'sit maiores sunt voluptas amet. Cupiditate dolorem suscipit sapiente ' \
          'eos eligendi eos iste quos'
      end
    end
  end
end
