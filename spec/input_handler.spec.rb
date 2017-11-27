require 'spec_helper'
require_relative '../input_handler'

describe InputHandler do
  let(:empty_args) { ARGV.replace [] }
  let(:test_file_args)  { ARGV.replace ["./spec/fixtures/test_file.txt"] }
  let(:missing_file_args) { ARGV.replace ["test_file_1.txt"] }
  let(:usage_prompt) { %Q(
    Enter text via stdin or file names as arguments:
      \tEx: ./tokenizer_test.rb file1.txt file2.txt
      \tEx: cat file1.txt | ./tokenizer_test.rb
    )}

  describe ".print_prompt" do
    it "prints usage prompt to stdout" do
      expect { InputHandler.print_prompt }.to output().to_stdout
    end
  end

  describe ".analyze" do 
    context "when no input provided via arguments or stdin" do
      it "prints a usage prompt and exits the program" do
        expect do
          output = InputHandler.analyze(empty_args) 
          expect(output).to eq(usage_prompt)
        end.to raise_error(SystemExit)
      end
    end

    context "when input provided via arguments and/or stdin" do
      it "should call read_input with the input arguments" do 
        expect(InputHandler).to receive(:read_input).with(["./spec/fixtures/test_file.txt"])

        InputHandler.analyze(test_file_args)
      end 
    end
  end

  describe ".read_input" do
    context "when it attempts to open a file that does not exist" do 
      it "raises an error" do
        expect { InputHandler.read_input(missing_file_args) }.to raise_error(LoadError, "File not found - try again.")
      end
    end

    context "when file exists or reading from stdin" do 
      it "reads input from file(s) and/or stdin and returns contents as a string" do
        input_text = InputHandler.analyze(test_file_args)

        expect(input_text).to be_a(String)
      end
    end
  end
end