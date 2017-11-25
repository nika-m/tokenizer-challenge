
class NgramTokenizer
  attr_reader :text, :filter_pattern

  TRIGRAM = 3
  
  def initialize(text, filter_pattern)
    @text = text
    @filter_pattern = filter_pattern
  end

  def to_trigram
    self.filter.scan(/[\w]+/).each_cons(TRIGRAM).to_a
  end

  protected

  def filter
    text.downcase.gsub(filter_pattern, '')
  end  
end
