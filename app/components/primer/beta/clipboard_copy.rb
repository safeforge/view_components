# frozen_string_literal: true

module Primer
  module Beta
    # Use `ClipboardCopy` to copy element text content or input values to the clipboard.
    #
    # This component by itself is not styled as a button, and can therefore only be used in limited circumstances.
    # If you're looking for a button, consider using <%= link_to_component(Primer::Beta::ClipboardCopyButton) %>
    # instead.
    #
    # @accessibility
    #   Always set an accessible label to help the user interact with the component.
    #
    #   This component has a built-in `aria-live` region that announces "Copied!" when the copy element is pressed.
    class ClipboardCopy < Primer::Component
      status :beta

      # @param aria-label [String] String that will be read to screenreaders when the component is focused
      # @param value [String] Text to copy into the users clipboard when they click the component.
      # @param for [String] Element id from where to get the copied value.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(value: nil, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @value = value

        validate!

        @system_arguments[:tag] = "clipboard-copy"
        @system_arguments[:value] = value if value.present?
      end

      # :nodoc:
      def before_render
        validate_aria_label if content.blank?
      end

      private

      def validate!
        raise ArgumentError, "Must provide either `value` or `for`" if @value.nil? && @system_arguments[:for].nil?
      end
    end
  end
end
