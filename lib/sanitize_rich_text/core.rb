require 'active_support'
require "sanitize"

module SanitizeRichText
  module Core
    extend ActiveSupport::Concern

    class_methods do
      def sanitize_rich_text(attr_name, options = {})
        define_method("#{attr_name}=") do |value|
          super(
            Sanitize.fragment(
              value,
              elements: options.fetch(:elements, nil) || elements,
              attributes: options.fetch(:attributes, nil) || attributes,
            )
          )
        end
      end
    end

    protected

    def elements
      ['a', 'strong', 'b', 'br', 'em', 'sub', 'sup', 'ul', 'ol', 'li', 'p', 'u']
    end

    def attributes
      { 'a' => ['href', 'target'] }
    end
  end
end
