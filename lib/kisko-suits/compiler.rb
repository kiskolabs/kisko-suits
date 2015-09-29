require "set"

module KiskoSuits
  class Compiler
    attr_reader :path, :output_filename, :included_filenames

    def initialize(path)
      @path = path
      @output_filename = nil

      @included_filenames = Set.new
    end

    def render
      @included_filenames.clear

      abort "Suits file '#{path}' not found" unless File.exists?(path)

      open_output_file do |output|
        File.foreach(path) do |line|
          output.write(process_line(File.dirname(path), line))
        end
      end
    end

    private

    def process_line(root_dir, line)
      if match = line.match(/\s*include:\s*([\w\.\/]+)/)
        included_path = "#{root_dir}/#{match[1]}"
        if File.exists?(included_path)
          @included_filenames << included_path

          File.foreach(included_path).map { |included_line|
            process_line(File.dirname(included_path), included_line)
          }.join
        else
          puts "Include #{included_path} can't be found"
          ""
        end
      else
        line
      end
    end

    def open_output_file(&block)
      @output_filename = path.gsub(".suits", "")

      abort "Problem with config file (should end with .suits)" if path == @output_filename

      File.open(@output_filename, 'w', &block)
    end
  end
end
