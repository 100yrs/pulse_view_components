# frozen_string_literal: true

module Pulse
  module Forms
    # @label ErrorExplanation
    class ErrorExplanationPreview < ViewComponent::Preview
      # Previews ship in the gem, so they can't use a host app model.
      class SampleRecord
        include ActiveModel::Model

        attr_accessor :title, :description

        validates :title, presence: true
        validates :description, length: { minimum: 20 }

        def self.model_name
          ActiveModel::Name.new(self, nil, 'Project')
        end
      end

      # @label Playground
      #
      # The component renders nothing once both fields are valid.
      #
      # @param title text
      # @param description text
      def default(title: '', description: 'Too short')
        render(Pulse::Forms::ErrorExplanation.new(
                 resource: invalid_record(title:, description:)
               ))
      end

      # @label Single error
      def single_error
        render(Pulse::Forms::ErrorExplanation.new(
                 resource: invalid_record(
                   title: '', description: 'A description that is long enough'
                 )
               ))
      end

      private

      def invalid_record(**attributes)
        SampleRecord.new(**attributes).tap(&:validate)
      end
    end
  end
end
