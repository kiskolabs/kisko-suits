module KiskoSuits
  class Compiler
    def initialize(params)

    end

    def process_files(data)
      @filenames = []
      File.open(data, 'r') do |f|
        f.each_line do |line|
          file = File.dirname(data) + "/" + line.strip
          if File.exists?(file)
            @filenames << file
          else
            abort "File '#{file} not found'"
          end
        end
      end
      return @filenames
    end

    def render(data)
      abort "Config file '#{data}' not found" unless File.exists?(data)
      @output_filename = data.gsub(".suits", "")
      abort "Problem with config file (should end with .suits)" if data == @output_filename
      File.delete(@output_filename) if File.exists?(@output_filename)
      @output_file = File.new(@output_filename,'w')
      @filenames = process_files(data)
      @filenames.each do |f|
        @output_file.print(File.read(f))
      end
      @output_file.close
      puts "Proccessed files and compiled '#{@output_filename}'"
    end

    def watch_and_render(data)
      render(data)
      @filenames = process_files(data)
      puts "Watch mode enabled"
      files = [data] + @filenames
      @filewatcher = FileWatcher.new(files)
      @filewatcher.watch do |filename|
        if filename == data
          @filewatcher.finalize
          watch_and_render(data)
        else
          render(data)
        end
      end
    end
  end

end
