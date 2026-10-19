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
        @errors ||= ActiveModel::Errors.new(resource).tap do |errors|
          # Only display the last of each attribute error, to avoid needless
          # duplication.
          resource.errors.group_by(&:attribute).each_value do |group|
            errors.add(group.last.attribute, group.last.message)
          end
        end
      end

      # Prefers the app's `errors.template.header` so existing wording is
      # kept. The sidecar is English-only, so other locales fall back to its
      # English text rather than raising under `raise_on_missing_translations`.
      def header
        options = { count: errors.count,
                    model: resource.class.model_name.human.downcase }

        t('errors.template.header', **options,
          default: t('.header', **options,
                     default: t('.header', **options, locale: :en)))
      end

      def render?
        resource.errors.any?
      end

      private

      attr_reader :resource
    end
  end
end
