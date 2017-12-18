# SanitizeRichText

## Installation

```rb
gem 'sanitize_rich_text'
```

## Usage

```rb
class Article < ApplicationRecord
  sanitize_rich_text :text, elements: %w(h2 h3 p a), attributes: { 'a' => ['href', 'target'] }
end
```
