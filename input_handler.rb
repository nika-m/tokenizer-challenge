
module InputHandler
  USAGE_PROMPT = %Q(
    Enter text via stdin or file names as arguments:
      \tEx: ./tokenizer_test.rb file1.txt file2.txt
      \tEx: cat file1.txt | ./tokenizer_test.rb
    )

  class << self
    def print_prompt
      puts USAGE_PROMPT
    end

    def analyze(input)
      # User didn't provide input on stdin or any args, so print usage message and exit
      if input.empty? && STDIN.tty?
        print_prompt
        exit
      else
        read_input(input)
      end
    end

    def read_input(input)
      if input.detect { |path| File.file?(path) == false }
        raise LoadError, "File not found - try again."
      else
        ARGF.read
      end
    end
  end
end