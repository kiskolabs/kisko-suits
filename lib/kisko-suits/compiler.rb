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
      abort "Suits file '#{@filename}' not found" unless File.exists?(@filename)

      root_dir = File.dirname(@filename)
      @output_filename = @filename.gsub(".suits", "")
      abort "Problem with config file (should end with .suits)" if @filename == @output_filename
      File.delete(@output_filename) if File.exists?(@output_filename)
      File.open(@output_filename,'w') do |output|
        File.foreach(@filename) do |line|
          if match = line.match(/\s*include:\s*([\w\.\/]+)/)
            included_path = "#{root_dir}/#{match[1]}"
            if File.exists?(included_path)
              @included_filenames << included_path
              output.write(File.read(included_path))
            else
              puts "Include #{included_path} can't be found"
            end
          else
            output.write(line)
          end
        end

        # File.read(@filename)
        # @filenames = process_files(data)
        # @filenames.each do |f|
        #   output.print(File.read(f))
        # end
      end
    end
  end

  #   def process_files(data)
  #     @filenames = []
  #     File.open(data, 'r') do |f|
  #       f.each_line do |line|
  #         file = File.dirname(data) + "/" + line.strip
  #         if File.exists?(file)
  #           @filenames << file
  #         else
  #           abort "File '#{file} not found'"
  #         end
  #       end
  #     end
  #     return @filenames
  #   end
  #
  #   def render
  #     # abort "Config file '#{data}' not found" unless File.exists?(data)
  #     @output_filename = file.path.gsub(".suits", "")
  #     abort "Problem with config file (should end with .suits)" if file.path == @output_filename
  #     File.delete(@output_filename) if File.exists?(@output_filename)
  #     File.new(@output_filename,'w') do |output|
  #       @filenames = process_files(data)
  #       @filenames.each do |f|
  #         output.print(File.read(f))
  #       end
  #     end
  #     puts "Proccessed files and compiled '#{@output_filename}'"
  #   end
  #
  #   def watch_and_render(data)
  #     render(data)
  #     @filenames = process_files(data)
  #     puts "Watch mode enabled"
  #     files = [data] + @filenames
  #     @filewatcher = FileWatcher.new(files)
  #     @filewatcher.watch do |filename|
  #       if filename == data
  #         @filewatcher.finalize
  #         watch_and_render(data)
  #       else
  #         render(data)
  #       end
  #     end
  #   end
  # end

end
# metodi joka ottaa tekstiä ja antaa tekstiä
# metodi joka ottaa vastaan tiedostonimen
