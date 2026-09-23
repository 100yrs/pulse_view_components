# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pulse::NavList, type: :component do
  it 'renders navlist' do
    component = render_inline(Pulse::NavList.new) do |c|
      c.with_heading(title: 'Settings')

      c.with_item(label: 'Access', href: '#') do |item|
        item.with_leading_visual_icon(icon: :gear)
      end
    end
    expect(component).to have_text('Settings').and have_text('Access')
  end

  it 'labels the nav with its heading' do
    render_inline(Pulse::NavList.new) do |list|
      list.with_heading(title: 'Settings', id: 'settings-heading')
      list.with_item(label: 'Access', href: '#')
    end

    expect(page).to have_css('nav[aria-labelledby="settings-heading"]')
      .and have_css('h2#settings-heading', text: 'Settings')
  end

  it 'raises without a heading or aria-label' do
    expect {
      render_inline(Pulse::NavList.new) do |list|
        list.with_item(label: 'Access', href: '#')
      end
    }.to raise_error(ArgumentError, /an aria-label must be given/)
  end

  it 'raises with both a heading and an aria-label' do
    expect {
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_heading(title: 'Settings')
      end
    }.to raise_error(ArgumentError, /aria-label if a heading is provided/)
  end

  describe 'groups' do
    it 'renders the group heading and items' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Collaborators', href: '/collaborators')
          group.with_item(label: 'Teams', href: '/teams')
        end
      end

      expect(page).to have_css('h3', text: 'Access')
        .and have_css('ul li a[href="/collaborators"]', text: 'Collaborators')
        .and have_css('ul li a[href="/teams"]', text: 'Teams')
    end

    it 'labels the group list with its heading' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Collaborators', href: '/collaborators')
        end
      end

      heading_id = page.find('h3', text: 'Access')[:id]
      expect(page).to have_css("ul[aria-labelledby='#{heading_id}']")
    end

    it 'renders the group heading at the given level' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access', heading_level: 4)
          group.with_item(label: 'Collaborators', href: '/collaborators')
        end
      end

      expect(page).to have_css('h4', text: 'Access')
    end

    it 'raises without a heading' do
      expect {
        render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
          list.with_group do |group|
            group.with_item(label: 'Collaborators', href: '/collaborators')
          end
        end
      }.to raise_error(ArgumentError, /required to have headings/)
    end

    it 'skips the outer list when there are no top-level items' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Collaborators', href: '/collaborators')
        end
      end

      expect(page).to have_no_css('ul ul')
    end

    it 'wraps the group in a list item alongside top-level items' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_item(label: 'General', href: '/general')
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Collaborators', href: '/collaborators')
        end
      end

      expect(page).to have_css('nav-list > ul > li > div h3', text: 'Access')
        .and have_css('nav-list > ul > li > div > ul a', text: 'Collaborators')
    end

    it 'renders a divider between a top-level item and a group' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_item(label: 'General', href: '/general')
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Collaborators', href: '/collaborators')
        end
      end

      expect(page).to have_css('li[role="presentation"]', count: 1)
    end

    it 'renders a divider between adjacent groups' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Collaborators', href: '/collaborators')
        end
        list.with_group do |group|
          group.with_heading(title: 'Security')
          group.with_item(label: 'Secrets', href: '/secrets')
        end
      end

      expect(page).to have_css('li[role="presentation"]', count: 1)
        .and have_css('h3', text: 'Access')
        .and have_css('h3', text: 'Security')
    end

    it 'does not add a second divider next to an explicit one' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Collaborators', href: '/collaborators')
        end
        list.with_divider
        list.with_group do |group|
          group.with_heading(title: 'Security')
          group.with_item(label: 'Secrets', href: '/secrets')
        end
      end

      expect(page).to have_css('li[role="presentation"]', count: 1)
    end

    it 'marks the selected item in a group as the current page' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' },
                                       selected_item_id: :teams)) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Collaborators', href: '/collaborators',
                          selected_by_ids: :collaborators)
          group.with_item(label: 'Teams', href: '/teams',
                          selected_by_ids: :teams)
        end
      end

      expect(page).to have_css('a[aria-current="page"]', count: 1)
        .and have_css('a[aria-current="page"]', text: 'Teams')
    end

    it 'expands a group item whose sub item is selected' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' },
                                       selected_item_id: :limits)) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Moderation') do |item|
            item.with_item(label: 'Interaction limits', href: '/limits',
                           selected_by_ids: :limits)
          end
        end
      end

      expect(page).to have_css('button[aria-expanded="true"]',
                               text: 'Moderation')
        .and have_css('a[aria-current="page"]', text: 'Interaction limits')
    end

    it 'collapses a group item with no selected sub item' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Moderation') do |item|
            item.with_item(label: 'Interaction limits', href: '/limits',
                           selected_by_ids: :limits)
          end
        end
      end

      expect(page).to have_css('button[aria-expanded="false"]',
                               text: 'Moderation')
        .and have_no_css('[aria-current]')
    end

    it 'renders sub items in a list labelled by their parent' do
      render_inline(Pulse::NavList.new(aria: { label: 'Settings' })) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Access')
          group.with_item(label: 'Moderation', id: 'moderation') do |item|
            item.with_item(label: 'Interaction limits', href: '/limits')
            item.with_item(label: 'Reported content', href: '/reported')
          end
        end
      end

      expect(page).to have_css(
        'ul.ActionList--subGroup[aria-labelledby="moderation"] li', count: 2
      )
        .and have_css('li.ActionListItem--subItem a[href="/limits"]')
    end

    it 'renders a hidden show more item after the list' do
      render_inline(Pulse::NavList.new(aria: { label: 'Foods' })) do |list|
        list.with_group do |group|
          group.with_heading(title: 'Foods')
          group.with_item(label: 'Popplers', href: '/foods/popplers')
          group.with_show_more_item(label: 'Show more', src: '/foods',
                                    pages: 3)
        end
      end

      show_more = page.find('[data-target="nav-list.showMoreItem"]',
                            visible: :all)
      expect(show_more[:hidden]).not_to be_nil
      expect(show_more.native.to_h).to include(
        'data-total-pages' => '3', 'data-current-page' => '1'
      )
      expect(page).to have_no_css('ul [data-target="nav-list.showMoreItem"]',
                                  visible: :all)
    end
  end
end
