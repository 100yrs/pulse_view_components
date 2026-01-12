# frozen_string_literal: true

module Pulse
  class TextPreview < ViewComponent::Preview
    # @param text text
    # @param type select [h1, h2, h3, h4, subtitle, subtitle2,  subtitle3,
    #  subtitle4, body1, body2, body3, body4, body5, body6, body7, body8,
    #  caption1, caption2]
    # @param tag text
    # @param classes text
    def default(text: 'Welcome', type: :h1, tag: nil, classes: nil)
      render Pulse::Text.new(
        type:,
        tag:,
        classes:
      ) do
        text
      end
    end

    def h1
      render(Pulse::Text.new(type: :h1)) { 'Heading' }
    end

    def h2
      render(Pulse::Text.new(type: :h2)) { 'Heading' }
    end

    def h3
      render(Pulse::Text.new(type: :h3)) { 'Heading' }
    end

    def h4
      render(Pulse::Text.new(type: :h4)) { 'Heading' }
    end

    def subtitle
      render(Pulse::Text.new(type: :subtitle)) { 'Subtitle' }
    end

    def body1
      render(Pulse::Text.new(type: :body1)) do
        'Lorem ipsum esse soluta voluptas maiores omnis nihil officia consequa.'
      end
    end

    def body2
      render(Pulse::Text.new(type: :body2)) do
        'Lorem ipsum esse soluta voluptas maiores omnis nihil officia consequa.'
      end
    end

    def body3
      render(Pulse::Text.new(type: :body3)) do
        'Lorem ipsum esse soluta voluptas maiores omnis nihil officia consequa.'
      end
    end

    def body4
      render(Pulse::Text.new(type: :body4)) do
        'Lorem ipsum esse soluta voluptas maiores omnis nihil officia consequatur.'
      end
    end

    def body5
      render(Pulse::Text.new(type: :body5)) do
        'Lorem ipsum esse soluta voluptas maiores omnis nihil officia consequa.'
      end
    end

    def body6
      render(Pulse::Text.new(type: :body6)) do
        'Lorem ipsum esse soluta voluptas maiores omnis nihil officia consequa.'
      end
    end

    def body7
      render(Pulse::Text.new(type: :body7)) do
        'Lorem ipsum esse soluta voluptas maiores omnis nihil officia consequa.'
      end
    end

    def body8
      render(Pulse::Text.new(type: :body8)) do
        'Lorem ipsum esse soluta voluptas maiores omnis nihil officia consequa.'
      end
    end

    def caption1
      render(Pulse::Text.new(type: :caption1)) do
        'At dolorem rerum ea cupiditate vel eos facilis ea beatae vitae tempore.'
      end
    end

    def caption2
      render(Pulse::Text.new(type: :caption2)) do
        'At dolorem rerum ea cupiditate vel eos facilis ea beatae vitae tempore.'
      end
    end
  end
end
