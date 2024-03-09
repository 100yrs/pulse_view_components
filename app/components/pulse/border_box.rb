# frozen_string_literal: true

module Pulse
  # `BorderBox` is a Box component with a border.
  class BorderBox < Pulse::Component
    DEFAULT_PADDING = :default
    PADDING_MAPPINGS = {
      DEFAULT_PADDING => '',
      :condensed => 'Box--condensed',
      :spacious => 'Box--spacious'
    }.freeze
    PADDING_SUGGESTION = "Perhaps you could consider using :padding options of #{PADDING_MAPPINGS.keys.to_sentence}?"

    DEFAULT_ROW_SCHEME = :default
    ROW_SCHEME_MAPPINGS = {
      DEFAULT_ROW_SCHEME => '',
      :neutral => 'Box-row--gray',
      :info => 'Box-row--blue',
      :warning => 'Box-row--yellow'
    }.freeze

    # Optional Header.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    # @accessibility
    # When using header.with_title, the recommended tag is a heading tag, such as h1, h2, h3, etc.
    renders_one :header, 'Pulse::BorderBox::Header'

    # Optional Body.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :body, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        'px-4 py-5 bg-white sm:p-6',
        system_arguments[:classes]
      )

      Pulse::BaseComponent.new(**system_arguments)
    }

    # Optional Footer.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :footer, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        'Box-footer',
        system_arguments[:classes]
      )

      Pulse::BaseComponent.new(**system_arguments)
    }

    # Use Rows to add rows with borders and maintain the same padding.
    #
    # @param scheme [Symbol] Color scheme. <%= one_of(Pulse::BorderBox::ROW_SCHEME_MAPPINGS.keys) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_many :rows, lambda { |scheme: DEFAULT_ROW_SCHEME, **system_arguments|
      system_arguments[:tag] = :li
      system_arguments[:classes] = class_names(
        'pulse-px-4 pulse-py-5 pulse-bg-white sm:pulse-p-6',
        'first:pulse-rounded-t-md last:pulse-rounded-b-md',
        ROW_SCHEME_MAPPINGS[fetch_or_fallback(ROW_SCHEME_MAPPINGS.keys,
                                              scheme, DEFAULT_ROW_SCHEME)],
        system_arguments[:classes]
      )

      Pulse::BaseComponent.new(**system_arguments)
    }

    # @param padding [Symbol] <%= one_of(Pulse::BorderBox::PADDING_MAPPINGS.keys) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(padding: DEFAULT_PADDING, **system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        'pulse-bg-white pulse-border pulse-border-gray-200 pulse-border-solid',
        'pulse-border-[1px] pulse-rounded-md',
        PADDING_MAPPINGS[fetch_or_fallback(PADDING_MAPPINGS.keys, padding,
                                           DEFAULT_PADDING)],
        system_arguments[:classes]
      )

      @system_arguments[:system_arguments_denylist] =
        { [:p, :pt, :pb, :pr, :pl] => PADDING_SUGGESTION }
      @list_arguments = { tag: :ul,
                          class: 'pulse-divide-y pulse-divide-gray-200' }
    end

    def render?
      rows.any? || header.present? || body.present? || footer.present?
    end

    private

    def before_render
      return unless header

      @list_arguments[:aria] = {
        labelledby: header.id
      }
    end
  end
end
