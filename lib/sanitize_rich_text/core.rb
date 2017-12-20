require 'active_support'
require "sanitize"

module SanitizeRichText
  module Core
    extend ActiveSupport::Concern

    class_methods do
      def sanitize_rich_text(attr_name, options = {})
        define_method("#{attr_name}=") do |value|
          html_elements = ['a', 'strong', 'b', 'br', 'em', 'sub', 'sup', 'ul', 'ol', 'li', 'p', 'u']
          html_attributes = { 'a' => ['href', 'target'] }
          super(
            Sanitize.fragment(
              value,
              elements: options.fetch(:elements, nil) || html_elements,
              attributes: options.fetch(:attributes, nil) || html_attributes,
            )
          )
        end
      end
    end
  end
end
