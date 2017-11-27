require 'spec_helper'
require_relative '../filter_patterns'
require_relative '../ngram_tokenizer'
require_relative '../ngram_counter'


describe NgramCounter do
  let(:input_text) { 'I am a dog. I am a good dog. You are a truck. You are a big truck.' }
  let(:frequency_count) { 100 }
  let(:tokenized_text) { NgramTokenizer.new(input_text, FilterPatterns.default_filter).to_trigram }
  let(:ngram_counter) { NgramCounter.new(tokenized_text, frequency_count) }
  
  let(:trigram_list) { [["i", "am", "a"], ["am", "a", "dog"], ["a", "dog", "i"], ["dog", "i", "am"], 
                        ["i", "am", "a"], ["am", "a", "good"], ["a", "good", "dog"], ["good", "dog", "you"], 
                        ["dog", "you", "are"], ["you", "are", "a"], ["are", "a", "truck"], ["a", "truck", "you"], 
                        ["truck", "you", "are"], ["you", "are", "a"], ["are", "a", "big"], ["a", "big", "truck"]]
                      }

  let(:unsorted_frequency_counts) { 
    {
      ["i", "am", "a"]=>2, 
      ["am", "a", "dog"]=>1, 
      ["a", "dog", "i"]=>1, 
      ["dog", "i", "am"]=>1, 
      ["am", "a", "good"]=>1, 
      ["a", "good", "dog"]=>1, 
      ["good", "dog", "you"]=>1, 
      ["dog", "you", "are"]=>1, 
      ["you", "are", "a"]=>2, 
      ["are", "a", "truck"]=>1, 
      ["a", "truck", "you"]=>1, 
      ["truck", "you", "are"]=>1, 
      ["are", "a", "big"]=>1, 
      ["a", "big", "truck"]=>1
    }
  }

  let(:sorted_frequency_counts) { 
    [
      [["you", "are", "a"], 2], 
      [["i", "am", "a"], 2], 
      [["a", "dog", "i"], 1], 
      [["dog", "i", "am"], 1], 
      [["am", "a", "good"], 1], 
      [["a", "good", "dog"], 1], 
      [["good", "dog", "you"], 1], 
      [["dog", "you", "are"], 1], 
      [["are", "a", "truck"], 1], 
      [["a", "truck", "you"], 1], 
      [["truck", "you", "are"], 1], 
      [["are", "a", "big"], 1], 
      [["a", "big", "truck"], 1],
      [["am", "a", "dog"], 1], 
    ]
  }

  describe "#new" do
    it "takes two parameters and returns an NgramCounter object" do
      expect(ngram_counter).to be_an(NgramCounter)
    end

    it "contains the tokenized text as an array" do
      expect(ngram_counter.tokenized_text).to be_an(Array)
      expect(ngram_counter.tokenized_text).to eq(trigram_list)
    end
  end

  describe "#ngrams_by_frequency" do 
    it "should return a list of word sequences sorted by descending frequency" do 
      expect(ngram_counter.ngrams_by_frequency).to eq(sorted_frequency_counts)
    end 
  end

  describe "#calculate_frequency" do
    it "should return count as a Hash" do
      expect(ngram_counter.send(:calculate_frequency)).to be_a(Hash)
    end

    it "contains trigram counts" do
      expect(ngram_counter.send(:calculate_frequency)).to eq(unsorted_frequency_counts)
    end
  end
end