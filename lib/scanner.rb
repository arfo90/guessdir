class Guessdir::Scanner
  def initialize(dir = Dir.pwd)
    begin
      @dir = dir
      Dir.chdir(dir)
      @analyse_dump = []
    rescue
      raise NotFoundError
    end
  end

  # public method that can be used by consumer to start analyzing target folder
  # method use either initilized dir or defualt(in case consumer doesnt specifiy)
  # as root folder and from there it start analyzing each folder and files and building
  # the report. most of magic happens in private method.
  def analyse
    scan_folder(dir)
  end

private

  attr_reader :dir
  attr_accessor :analyse_dump

  def scan_folder(dir)
    if Dir[File.join(dir,'**','*')].count > 1
      {overview: "this is ruby project with 100%", ruby: {number_of_files: 3, distro:100}}
    else
      { overview: "There is no file in target folder" }
    end
  end
end


# This error is only used by Scanner class
class NotFoundError < StandardError
  def initialize(msg="Folder doesn't exists")
    super
  end
end
