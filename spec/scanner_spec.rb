require_relative '../lib/guessdir'

describe Guessdir::Scanner do
  describe "#scan" do
    context "Scan method"

    it "returns hash with overview that says folder is empty" do
      expect(Guessdir::Scanner.new("#{File.dirname(__FILE__)}/test_resource/empty_folder").scan)
        .to eql({ overview: "There is no file in target folder"})
    end
  end
end
