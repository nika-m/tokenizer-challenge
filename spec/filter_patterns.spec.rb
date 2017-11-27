require 'spec_helper'
require_relative '../filter_patterns'

describe FilterPatterns do
  describe "filter constants" do
    it "contains a default filtering pattern" do
      default_filter = FilterPatterns::PUNCTUATION + FilterPatterns::PARENS + FilterPatterns::OTHER
      expect(FilterPatterns::DEFAULT).to eq(default_filter)
    end
  end

  describe "#default_filter" do
    it "should return a Regexp object" do
      expect(FilterPatterns.default_filter).to be_a(Regexp)
    end
  end
end