require 'spec_helper'
require 'sanitize_rich_text/core'

RSpec.describe "SanitizeRichText", type: :model do
  context "with default elements" do
    let(:model) do
      class Parent
        attr_accessor :title
      end

      Class.new(Parent) do
        include SanitizeRichText::Core

        sanitize_rich_text :title
      end
    end

    it "sanitizes tags not allowed" do
      instance = model.new
      instance.title = "<h1>test</h1>"
      expect(instance.title).to eq(" test ")
    end

    it "preserves tags allowed" do
      instance = model.new
      instance.title = "<p>test</p>"
      expect(instance.title).to eq("<p>test</p>")
    end
  end

  context "with custom elements" do
    let(:model) do
      class Parent
        attr_accessor :title
      end

      Class.new(Parent) do
        include SanitizeRichText::Core

        sanitize_rich_text :title, elements: ['h1']
      end
    end

    it "sanitizes tags not allowed" do
      instance = model.new
      instance.title = "<p>test</p>"
      expect(instance.title).to eq(" test ")
    end

    it "preserves tags allowed" do
      instance = model.new
      instance.title = "<h1>test</h1>"
      expect(instance.title).to eq("<h1>test</h1>")
    end
  end

  context "with default attributes" do
    let(:model) do
      class Parent
        attr_accessor :title
      end

      Class.new(Parent) do
        include SanitizeRichText::Core

        sanitize_rich_text :title
      end
    end

    it "preserves attributes allowed" do
      instance = model.new
      instance.title = "<a href=\"http://test.com\">test</a>"
      expect(instance.title).to eq("<a href=\"http://test.com\">test</a>")
    end

    it "sanitizes attributes not allowed" do
      instance = model.new
      instance.title = "<a href=\"http://test.com\" rel=\"external\">test</a>"
      expect(instance.title).to eq("<a href=\"http://test.com\">test</a>")
    end
  end

  context "with custom attributes" do
    let(:model) do
      class Parent
        attr_accessor :title
      end

      Class.new(Parent) do
        include SanitizeRichText::Core

        sanitize_rich_text :title, attributes: { 'a' => ['href'] }
      end
    end

    it "preserves attributes allowed" do
      instance = model.new
      instance.title = "<a href=\"http://test.com\">test</a>"
      expect(instance.title).to eq("<a href=\"http://test.com\">test</a>")
    end

    it "sanitizes attributes not allowed" do
      instance = model.new
      instance.title = "<a href=\"http://test.com\" target=\"_blank\">test</a>"
      expect(instance.title).to eq("<a href=\"http://test.com\">test</a>")
    end
  end
end
