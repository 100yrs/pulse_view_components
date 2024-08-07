# frozen_string_literal: true

module Pulse
  class ActionList
    # Utility component for wrapping ActionLists or individual `ActionList::Item`s in forms.
    class FormWrapper < Pulse::Component
      DEFAULT_HTTP_METHOD = :get
      HTTP_METHOD_OPTIONS = [
        DEFAULT_HTTP_METHOD,
        :post,
        :patch,
        :put,
        :delete,
        :head
      ].freeze

      def initialize(list:, action: nil, **form_arguments)
        @list = list
        @form_arguments = form_arguments

        @action = action
        @http_method = extract_http_method(@form_arguments)

        name = @form_arguments.delete(:name)
        value = @form_arguments.delete(:value) || name

        @input_arguments = {
          type: :hidden,
          name:,
          value:,
          data: { list_item_input: true },
          **(@form_arguments.delete(:input_arguments) || {})
        }
      end

      def get?
        @http_method == :get
      end

      def form_required?
        @action && !get?
      end

      def render_input?
        @input_arguments[:name].present?
      end

      private

      def extract_http_method(args)
        if (http_method = args.delete(:method))
          if HTTP_METHOD_OPTIONS.include?(http_method)
            http_method
          else
            DEFAULT_HTTP_METHOD
          end
        else
          DEFAULT_HTTP_METHOD
        end
      end
    end
  end
end
