# frozen_string_literal: true

# simplecov:disable
module Pulse
  module ViewComponents
    module VERSION
      MAJOR = 0
      MINOR = 2
      PATCH = 1

      STRING = [MAJOR, MINOR, PATCH].join('.')
    end
  end
end

# rubocop:disable-next Rails/Output
puts Pulse::ViewComponents::VERSION::STRING if __FILE__ == $PROGRAM_NAME
