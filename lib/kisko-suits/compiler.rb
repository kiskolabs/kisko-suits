require "set"

module KiskoSuits
  class Compiler
    attr_reader :file, :output_filename, :included_filenames

    def initialize(filename)
      @filename = filename
      @output_filename = nil

      @included_filenames = Set.new
    end

    def render
      @included_filenames.clear

      abort "Suits file '#{@filename}' not found" unless File.exists?(@filename)

      open_output_file do |output|
        File.foreach(@filename) do |line|
          output.write(process_line(line))
        end
      end
    end

    private

    def process_line(line)
      root_dir = File.dirname(@filename)

      if match = line.match(/\s*include:\s*([\w\.\/]+)/)
        included_path = "#{root_dir}/#{match[1]}"
        if File.exists?(included_path)
          @included_filenames << included_path
          File.read(included_path)
        else
          puts "Include #{included_path} can't be found"
          ""
        end
      else
        line
      end
    end

    def open_output_file(&block)
      @output_filename = @filename.gsub(".suits", "")

      abort "Problem with config file (should end with .suits)" if @filename == @output_filename

      File.delete(@output_filename) if File.exists?(@output_filename)
      File.open(@output_filename, 'w', &block)
    end
  end
end
