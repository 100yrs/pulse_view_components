# frozen_string_literal: true

module Pulse
  module Forms
    # Render error message box for an ActiveModel resource
    class ErrorExplanation < Pulse::Component
      status :stable

      # @param resource [ActiveModel::Validations] The record whose errors are listed.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(resource:, **system_arguments)
        @resource = resource
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = merge_classes(
          'pulse:bg-error-50 pulse:text-error pulse:px-3 pulse:py-2',
          'pulse:font-medium pulse:rounded-lg pulse:my-3',
          system_arguments[:classes]
        )
      end

      def errors
        @errors = ActiveModel::Errors.new(resource)
        # Only display the last of each attribute error, to avoid needless
        # duplication.
        resource.errors.group_by(&:attribute).values.map(&:last).each do |error|
          @errors.add(error.attribute, error.message)
        end
        @errors
      end

      # Uses the app's `errors.template.header` translation when it defines
      # one, so existing wording is kept. The sidecar fallback is only looked
      # up when needed, because it is English-only and would raise under
      # `raise_on_missing_translations` in other locales.
      def header
        options = { count: resource.errors.count,
                    model: resource.class.model_name.human.downcase }

        if I18n.exists?('errors.template.header')
          return t('errors.template.header', **options)
        end

        t('.header', **options)
      end

      def render?
        resource.errors.any?
      end

      private

      attr_reader :resource
    end
  end
end
