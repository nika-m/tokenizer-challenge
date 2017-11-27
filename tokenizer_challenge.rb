#!/usr/bin/env ruby

require './input_handler'
require './filter_patterns'
require './ngram_tokenizer'
require './ngram_counter'

FREQUENCY_COUNT = 100

# Analyze Input
input_text = InputHandler.analyze(ARGV)

# Filter and convert text into tokenized text - 3 word sequences or trigrams
tokenized_text = NgramTokenizer.new(input_text, FilterPatterns.default_filter).to_trigram 

# Calculate frequency of trigrams and return top 100 most frequent
sorted_by_frequency = NgramCounter.new(tokenized_text, FREQUENCY_COUNT).ngrams_by_frequency

# Output the results
sorted_by_frequency.each { |k, v| puts "#{v} - #{k.join(' ')}" }
