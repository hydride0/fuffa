class Fuffa
 
  class WordList
    def initialize(wl_path)
      @wl_file = Fuffa::Utils.get_fileMT(wl_path)
      @mutex = Mutex.new
    end

    def get_n_lines(n)
      @mutex.synchronize {
        @wl_file.each.take(n).map {|e| e.chomp }
      }
    end

  end
end
