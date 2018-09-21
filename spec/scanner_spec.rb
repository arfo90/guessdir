require_relative '../lib/guessdir'

describe Guessdir::Scanner do
  describe "#scan" do
    context "Scan method"

    it "raises NotFoundError" do
      expect { Guessdir::Scanner.new('./itGoesNowWhere') }.to raise_error { |error|
        expect(error).to be_a(NotFoundError)
      }
    end
    
    it "returns hash with overview that says folder is empty" do
      expect(Guessdir::Scanner.new("#{File.dirname(__FILE__)}/test_resource/empty_folder").scan)
        .to eql({ overview: "There is no file in target folder"})
    end
=begin

    it "returns hash with overview of files and their size" do
      expect(Guessdir::Scanner.new("#{File.dirname(__FILE__)}/test_resource/ruby_project").scan)
        to eql({ overview: "this is ruby project with 100%", ruby: {number_of_files: 3, distro:100}})
=end
  end
end
