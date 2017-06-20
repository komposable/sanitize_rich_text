require "sanitize_rich_text/version"
require "active_record"
require "sanitize"

module SanitizeRichText

  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def sanitize_rich_text(attr_name)
      sanitizer = Module.new do
        define_method("#{attr_name}=") do |value|
          super(Sanitize.fragment(value, :elements => elements, :attributes => attributes))
        end
      end
      prepend sanitizer
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

ActiveRecord::Base.send(:include, SanitizeRichText)
