require "sanitize_rich_text/core"

module SanitizeRichText
  class Railtie < Rails::Railtie
    ActiveSupport.on_load(:active_record) do |app|
      ActiveRecord::Base.send(:include, SanitizeRichText::Core)
    end
  end
end
