
class NgramCounter
  attr_reader :tokenized_text

  def initialize(tokenized_text, frequency_count)
    @tokenized_text  = tokenized_text
    @frequency_count = frequency_count
  end

  def ngrams_by_frequency
    sorted_ngrams = self.calculate_frequency.sort_by { |k, v| -v }
    sorted_ngrams.first(@frequency_count)
  end

  protected 

  def calculate_frequency
    count = {}
    count.default = 0

    tokenized_text.each { |trigram| count[trigram] += 1 }

    return count
  end
end

