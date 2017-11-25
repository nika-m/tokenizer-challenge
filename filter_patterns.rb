
module FilterPatterns
  PUNCTUATION = ['!', '?', ';', ',', ':', '—', '"', "'", '’','.']
  PARENS = ['{', '}', '[', ']', '(', ')']
  MISC = ['*', '@']

  DEFAULT = PUNCTUATION + PARENS + MISC

  def self.default_filter
    Regexp.union(DEFAULT)
  end
end