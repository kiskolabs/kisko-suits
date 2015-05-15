require "set"

module KiskoSuits
  class Watcher
    attr_reader :initial_filename, :on_update, :watched_paths

    def initialize(initial_filename, on_update)
      @initial_filename = initial_filename
      @on_update = on_update
      @watched_paths = Set.new
    end

    def start
      process_path(initial_filename)
      add_path(initial_filename)
      watch
    end

    private

    def watch
      watch_file(watched_paths)
    end

    def watch_file(filenames)
      watcher = FileWatcher.new(filenames.to_a)
      watcher.watch do |changed_filename|
        process_path(changed_filename)
        watcher.finalize
        watch
      end
    end

    def process_path(path)
      found_paths = on_update.call(path)

      found_paths.each do |new_filename|
        add_path(new_filename)
      end
    end

    def add_path(filename)
      watched_paths << filename
    end
  end
end
