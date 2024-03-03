# frozen_string_literal: true

module Pulse
  module Forms
    # Render error message box for a resource
    class ErrorExplanation < ViewComponent::Base
      def initialize(resource:, **options)
        super

        @resource = resource
        @options = options
        @options[:classes] = class_names(
          'bg-error-50 text-error px-3 py-2 font-medium rounded-lg my-3',
          options[:classes]
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

      def render?
        resource.errors.any?
      end

      private

      attr_reader :resource
    end
  end
end
