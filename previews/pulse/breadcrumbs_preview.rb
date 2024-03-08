# frozen_string_literal: true

module Pulse
  class BreadcrumbsPreview < ViewComponent::Preview
    def default
      render Pulse::Breadcrumbs.new do |c|
        c.with_item(href: '/', text: 'Home')
        c.with_item(text: 'Current Page')
      end
    end
  end
end
