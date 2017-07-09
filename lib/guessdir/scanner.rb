module Guessdir
  class Scanner
    def initialize(dir = './')
      @dir = Dir.new(dir)
      @file_type = Hash.new
      @number_of_folders = -2   #because we want skip '.' & '..'
      @number_of_files = 0
    end

    def scan
      files = @dir.entries
      return { overview: "There is no file in target folder"} unless files.length > 2

      files.each do |file|
        mark_file file
      end
      {guess: guess!, overview: build_overview, analyse: build_analyse.to_h}
    end

    private

    attr_reader :number_of_files, :file_type

    def mark_file(file)
      file_dir = "#{@dir.path}/#{file}"
      unless File.file? file_dir
        @number_of_folders +=1
      else
        @number_of_files += 1
        file_extension = file.split('.').last
        init_file_type! file_extension
        if !@file_type.key?(file_extension)
          @file_type.merge! file_extension => 1
        else
          @file_type[file_extension] += 1
        end
      end
    end

    def init_file_type!(file_extension)
      if @file_type.nil?
        @file_type = {}
        @file_type.merge!(file_extension => 1)
      end
    end

    def build_overview
      highest_files = get_highest_file_type
      number_of_folders_text = @number_of_folders > 0 ? "Folder has #{@number_of_folders} folder and" :
        'no folder detected in this dir and'
      number_of_files_text = number_of_files.zero? ? 'there is no file with this dir' :
        "#{number_of_files} files with #{calc_highest_files_percentage}"
      "#{number_of_folders_text} #{number_of_files_text}"
    end

    def build_analyse
      file_type.map {|k,v| {k => calc_file_type_percentage(v)}}
        .reduce(:merge)
    end

    def guess!
      calc_highest_files_percentage true
    end

    def filename_mapper(file_name)
      return 'Ruby' if file_name == 'rb'
      return 'php' if file_name == 'php'
      return 'xml' if file_name == 'xml'
      return 'empty' if file_name.nil?
    end

    def calc_file_type_percentage(files_count)
      (100 / file_type.values.reduce(:+)) * files_count
    end

    def calc_highest_files_percentage(tldr = false)
      percentage = ( 100 / file_type.values.reduce(:+)) *
        get_highest_file_type.values[0]
      if tldr
        return filename_mapper(get_highest_file_type.keys[0])
      end
      "#{percentage}% #{filename_mapper(get_highest_file_type.keys[0])} files"
    end

    def get_highest_file_type
      file_type_highest = file_type.values.max
      Hash file_type.select { |k,v| v == file_type_highest && !k.nil? }
    end
  end
end
