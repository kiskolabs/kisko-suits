require "set"

module KiskoSuits
  class Compiler
    attr_reader :path, :output_filename, :included_filenames

    def initialize(path)
      @path = path
      @output_filename = nil

      @included_filenames = Set.new
      @variables = {}
    end

    def render
      @included_filenames.clear
      @variables.clear

      abort "Suits file '#{path}' not found" unless File.exist?(path)

      open_output_file do |output|
        File.foreach(path).each do |line|
          output.write(process_line(File.dirname(path), line))
        end
      end
    end

    private

    def process_line(root_dir, line)
      if line.start_with?('[//]:')
        # It's a comment
        ""
      elsif line.match(/\s*\$\$\w+\s?=/)
        set_variable(line)
      elsif match = line.match(/\s*include:\s*([\w\.\/]+)/)
        included_path = "#{root_dir}/#{match[1]}"
        include_file(included_path)
      else
        substitute_variables(line)
      end
    end

    def open_output_file(&block)
      @output_filename = path.gsub(".suits", "")

      abort "Problem with config file (should end with .suits)" if path == @output_filename

      File.open(@output_filename, 'w', &block)
    end

    def set_variable(line)
      variable_name, variable_value = line.split("=").map(&:strip)
      @variables[variable_name] = variable_value
      ""
    end

    def include_file(included_path)
      if File.exist?(included_path)
        @included_filenames << included_path

        File.foreach(included_path).map { |included_line|
          process_line(File.dirname(included_path), included_line)
        }.join
      else
        puts "Include #{included_path} can't be found"
        ""
      end
    end

    def substitute_variables(line)
      @variables.each do |variable_name, variable_value|
        line = line.gsub(Regexp.new(Regexp.escape(variable_name)), variable_value)
      end

      line
    end
  end
end
