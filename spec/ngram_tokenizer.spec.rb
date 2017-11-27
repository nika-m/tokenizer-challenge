require 'spec_helper'
require_relative '../filter_patterns'
require_relative '../ngram_tokenizer'

describe NgramTokenizer do
  let(:input_text) { 'I am only a test file, but I am a nice test file.' }
  let(:ngram_tokenizer) { NgramTokenizer.new(input_text, FilterPatterns.default_filter) }
  let(:trigram_list) { [["i", "am", "only"], ["am", "only", "a"], ["only", "a", "test"], 
                        ["a", "test", "file"], ["test", "file", "but"], ["file", "but", "i"], 
                        ["but", "i", "am"], ["i", "am", "a"], ["am", "a", "nice"], ["a", "nice", "test"], 
                        ["nice", "test", "file"]] 
                      }

  describe "#new" do
    it "takes two parameters and returns an NgramTokenizer object" do
      expect(ngram_tokenizer).to be_an(NgramTokenizer)
    end

    it "contains a string" do
      expect(ngram_tokenizer.text).to eq('I am only a test file, but I am a nice test file.')
    end
  end

  describe "#to_trigram" do 
    it "returns an array" do 
      expect(ngram_tokenizer.to_trigram).to be_an(Array)
    end

    it "returns a list of the resulting three word sequences" do 
      expect(ngram_tokenizer.to_trigram).to eq(trigram_list)
    end
  end

  describe "#filter" do
    it "removes basic punctuation and parens" do
      expect(ngram_tokenizer.send(:filter)).not_to match(FilterPatterns.default_filter)
    end

    it "downcases the string" do
      expect(ngram_tokenizer.send(:filter)).to eq('i am only a test file but i am a nice test file')
    end

    it "returns a string" do
      expect(ngram_tokenizer.send(:filter)).to be_a(String)
    end    
  end

 
end