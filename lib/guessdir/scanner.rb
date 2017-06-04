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
      begin
        return { overview: "There is no file in target folder"} unless @dir.entries().length > 2
      rescue
        return nil
      end
    end
  end
end
