# frozen_string_literal: true

module Pulse
  # Declares how complete a component is, following Primer's component
  # lifecycle. Components are `:alpha` until they declare otherwise, so a new
  # component is never presented as safe by accident.
  #
  # - `:alpha`  Incomplete. Options or features may be broken, unstyled, or
  #             missing, and the API may change without notice.
  # - `:beta`   Core usage works. Some documented options are not implemented.
  # - `:stable` Complete and safe to use.
  # - `:deprecated` Scheduled for removal.
  #
  # ```ruby
  # class Pulse::Thing < Pulse::Component
  #   status :beta
  # end
  #
  # Pulse::Thing.status # => :beta
  # ```
  module Status
    extend ActiveSupport::Concern

    STATUSES = [:alpha, :beta, :stable, :deprecated].freeze
    DEFAULT_STATUS = :alpha

    included do
      # Set once while each class body loads, never at request time.
      # rubocop:disable-next ThreadSafety/ClassAndModuleAttributes
      class_attribute :component_status, instance_writer: false,
                                         default: DEFAULT_STATUS
    end

    class_methods do
      def status(value = nil)
        return component_status if value.nil?

        unless STATUSES.include?(value)
          raise ArgumentError,
                "Unknown status #{value.inspect}. Use one of " \
                "#{STATUSES.to_sentence}."
        end

        self.component_status = value
      end
    end
  end
end
