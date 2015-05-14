module KiskoSuits
  class Application
    def initialize(argv)
      @params, @files = parse_options(argv)
      # @compiler = KiskoSuits::Compiler.new(@params)
    end

    def run
      if @files.empty? || @files.size > 1 || !@files.first.include?(".suits")
        abort "Usage: 'kisko-suits my-presentation.md.suits'\n\nOr start watching file with: 'kisko-suits -w my-presentation.md.suits'"
      else
        if @params[:watch]
          on_update = ->(filename) {
            compiler = KiskoSuits::Compiler.new(@files.first)
            compiler.render
            puts "Processed files and compiled '#{compiler.output_filename}'"
            compiler.included_filenames
          }
          KiskoSuits::Watcher.new(@files.first, on_update).start
          # @compiler.watch_and_render(@files.first)
        else
          compiler = KiskoSuits::Compiler.new(@files.first)
          compiler.render
          puts "Processed files and compiled '#{compiler.output_filename}'"
          # @compiler.render(@files.first)
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
  end
end
