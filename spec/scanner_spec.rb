require_relative '../lib/guessdir'

describe Guessdir::Scanner do
  describe "#scan" do
    context "Scan method"

    it "return empty file message when file is empty" do
      expect(Guessdir::Scanner.new("#{File.dirname(__FILE__)}/test_resource/empty_folder").scan)
        .to eql({ overview: "There is no file in target folder"})
    end

    it "scan a folder with mixure files" do
      expect(Guessdir::Scanner.new("#{File.dirname(__FILE__)}/test_resource/folder_1").scan)
        .to eql({ overview: "Folder has 1 folder and 4 files with 50% ruby file", type_analyse: { ruby: 50, php: 25, xml: 25}, 
          guess: 'Ruby'})
    end
  end
end
