class Guessdir::Scanner
  def initialize(dir = Dir.pwd)
    begin
      @dir = Dir.chdir(dir)
    rescue
      raise NotFoundError
    end
  end

  def scan
    return { overview: "There is no file in target folder" }
  end
end

class NotFoundError < StandardError
  def initialize(msg="Folder doesn't exists")
    super
  end
end
