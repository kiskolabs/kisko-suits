module KiskoSuits
  class Application
    def initialize(argv)
      @params, @files = parse_options(argv)
    end

    def run
      if !suits_file_passed?
        abort "Usage: 'kisko-suits my-presentation.md.suits'\n\nOr start watching file with: 'kisko-suits -w my-presentation.md.suits'"
      else
        if @params[:watch]
          on_update = ->(filename) {
            compiler = compile_and_render
            compiler.included_filenames
          }
          KiskoSuits::Watcher.new(@files.first, on_update).start
        else
          compile_and_render
        end
      end
    end

    def parse_options(argv)
      params = {}
      parser = OptionParser.new

      parser.on("-w") { params[:watch] = true }
      files = parser.parse(argv)

      [params, files]
    end

    def suits_file_passed?
      @files.size == 1 && @files.first.include?(".suits")
    end

    def compile_and_render
      compiler = KiskoSuits::Compiler.new(@files.first)
      compiler.render
      puts "Processed files and compiled '#{compiler.output_filename}'"
      compiler
    end
  end
end
