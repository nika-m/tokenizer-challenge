
module FilterPatterns
  PUNCTUATION = ['!', '?', ';', ',', ':', '—', '"', "'", '’','.']
  PARENS = ['{', '}', '[', ']', '(', ')']
  OTHER = ['*', '@']

  DEFAULT = PUNCTUATION + PARENS + OTHER

  class << self
    def default_filter
      Regexp.union(DEFAULT)
    end
  end
end