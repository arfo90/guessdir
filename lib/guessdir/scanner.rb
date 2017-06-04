module Guessdir
  class Scanner
    def initialize(dir = './')
      begin
        @dir = Dir.new(dir)
      rescue
        puts dir
      end
    end

    def scan
      return { overview: "There is no file in target folder"} unless @dir.entries().length > 2
    end
  end
end
