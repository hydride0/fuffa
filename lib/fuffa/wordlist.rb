class Fuffa
  class WordList
    def initialize(wl_path)
      @wl_file = Fuffa::Utils.get_file(wl_path)
    end

    def get_line()
      @wl_file.readline chomp: true
      rescue EOFError
        nil
    end

  end
end
