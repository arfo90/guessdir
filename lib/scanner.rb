class Guessdir::Scanner
  def initialize(dir = Dir.pwd)
  end

  def scan
    return { overview: "There is no file in target folder" }
  end
end
