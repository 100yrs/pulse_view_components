# frozen_string_literal: true

module Pulse
  class NavList
    # Separator with optional text rendered above groups or between individual
    # items.
    class Divider < Pulse::ActionList::Divider
      def kind
        :divider
      end
    end
  end
end
