# frozen_string_literal: true

module Pulse
  # @label ActionList (alpha)
  class ActionListPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param title text
    # @param subtitle text
    # @param heading_level select [1, 2, 3, 4, 5, 6]
    # @param show_dividers toggle
    def default(title: 'Account', subtitle: nil, heading_level: 3,
                show_dividers: false)
      render(Pulse::ActionList.new(show_dividers:)) do |list|
        list.with_heading(title:, subtitle: subtitle.presence,
                          heading_level: heading_level.to_i)
        list.with_item(label: 'Profile', href: '#')
        list.with_item(label: 'Notifications', href: '#')
        list.with_item(label: 'Security', href: '#')
      end
    end

    # @label Leading visuals
    def leading_visuals
      render(Pulse::ActionList.new) do |list|
        list.with_item(label: 'Profile', href: '#') do |item|
          item.with_leading_visual_icon(icon: :person)
        end
        list.with_item(label: 'Notifications', href: '#') do |item|
          item.with_leading_visual_icon(icon: :bell)
        end
        list.with_item(label: 'Security', href: '#') do |item|
          item.with_leading_visual_icon(icon: :key)
        end
      end
    end

    # @label Trailing visuals
    def trailing_visuals
      render(Pulse::ActionList.new) do |list|
        list.with_item(label: 'Members', href: '#') do |item|
          item.with_trailing_visual_counter(count: 12)
        end
        list.with_item(label: 'Starred', href: '#') do |item|
          item.with_trailing_visual_icon(icon: :star)
        end
        list.with_item(label: 'Search', href: '#') do |item|
          item.with_trailing_visual_text('⌘K')
        end
      end
    end

    # @label Descriptions
    def descriptions
      render(Pulse::ActionList.new) do |list|
        list.with_item(label: 'Edit', href: '#') do |item|
          item.with_leading_visual_icon(icon: :pencil)
          item.with_description { 'Change the name and details' }
        end
        list.with_item(label: 'Archive', href: '#') do |item|
          item.with_leading_visual_icon(icon: :archive)
          item.with_description { 'Hide from the main list' }
        end
      end
    end

    # @label Dividers
    def dividers
      render(Pulse::ActionList.new) do |list|
        list.with_item(label: 'Profile', href: '#')
        list.with_item(label: 'Notifications', href: '#')
        list.with_divider
        list.with_item(label: 'Sign out', href: '#')
      end
    end
  end
end
