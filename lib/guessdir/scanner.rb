module Guessdir
  class Scanner
    def initialize(dir = './')
      begin
        @dir = Dir.new(dir)
        @file_type = Hash.new
        @number_of_files = 0
      rescue
        puts dir
      end
    end

    def scan
      files = @dir.entries
      return { overview: "There is no file in target folder"} unless files.length > 2

      files.each do |file|
        mark_file file
      end

      build_overview
    end

    private

    def mark_file(file)
      file_dir = "#{@dir.path}/#{file}"
        p "is it a file ? -----> #{file_dir} ---- #{File.file?(file_dir)}"
      if File.file? "#{@dir}/#{file}"
        @number_of_files +=1
      else
        file_extension = file.split('.').last
        init_file_type! file_extension
        if !@file_type.key?(file_extension)
          @file_type.merge! file_extension => 1
        else
          @file_type[file_extension] += 1
        end
      end
      puts "this is file_types.. #{@file_type}"
    end

    def init_file_type!(file_extension)
      if @file_type.nil?
        @file_type = {}
        @file_type.merge!(file_extension => 1)
      end
    end

    def build_overview
      file_type_highest = @file_type.values.max
      highest_files =Hash @file_type.select { |k,v| v == file_type_highest && !k.nil? }
      puts "this projec is #{filename_mapper(highest_files.keys[0])}"
      { overview: "" }
    end


    def filename_mapper(file_name)
      return 'Ruby' if file_name == 'rb'
      return 'php' if file_name == 'php'
      return 'xml' if file_name == 'xml'
      return 'empty' if file_name.nil?
    end
  end
end
