# frozen_string_literal: true

module Pulse
  # FetchOrFallbackHelper
  # A little helper to enable graceful fallbacks
  # See https://github.com/primer/view_components/blob/main/app/lib/primer/fetch_or_fallback_helper.rb
  # and https://github.com/baoagency/polaris_view_components/blob/main/app/helpers/polaris/fetch_or_fallback_helper.rb
  #
  # Use this helper to quietly ensure a value is
  # one that you expect:
  #
  # allowed_values    - allowed options for *value*
  # given_value       - input being coerced
  # fallback          - returned if *given_value* is not included in *allowed_values*
  #
  # fetch_or_fallback([1,2,3], 5, 2) => 2
  # fetch_or_fallback([1,2,3], 1, 2) => 1
  # fetch_or_fallback([1,2,3], nil, 2) => 2
  module FetchOrFallbackHelper
    mattr_accessor :fallback_raises, default: true

    InvalidValueError = Class.new(StandardError)

    def fetch_or_fallback(allowed_values, given_value, fallback = nil)
      if allowed_values.include?(given_value)
        given_value
      else
        if fallback_raises && ENV['RAILS_ENV'] != 'production'
          raise InvalidValueError, <<~MSG
            fetch_or_fallback was called with an invalid value.

            Expected one of: #{allowed_values.inspect}
            Got: #{given_value.inspect}

            This will not raise in production, but will instead fallback to: #{fallback.inspect}
          MSG
        end

        fallback
      end
    end

    # rubocop:disable Style/OptionalBooleanParameter
    def fetch_or_fallback_boolean(given_value, fallback = false)
      if [true, false].include?(given_value)
        given_value
      else
        fallback
      end
    end
    # rubocop:enable Style/OptionalBooleanParameter
  end
end
