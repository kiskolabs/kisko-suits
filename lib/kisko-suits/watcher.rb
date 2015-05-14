require "set"

module KiskoSuits
  class Watcher
    attr_reader :initial_filename, :on_update, :watched_paths

    def initialize(initial_filename, on_update)
      @initial_filename = initial_filename
      @on_update = on_update

      @watched_paths = Set.new
      @watchers = []
    end

    def start
      process_path(initial_filename)
      add_watch(initial_filename)
      @watchers.each(&:join)
    end

    private

    def watch_file(filename)
      @watchers << Thread.new {
        FileWatcher.new(filename).watch do |changed_filename|
          process_path(changed_filename)
        end
      }
    end

    def process_path(path)
      found_paths = on_update.call(path)

      found_paths.each do |new_filename|
        add_watch(new_filename)
      end
    end

    def add_watch(filename)
      unless watched_paths.include?(filename)
        watched_paths << filename
        watch_file(filename)
      end
    end
  end
end
