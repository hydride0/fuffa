class Fuffa
  class WordList
    @wl_file

    def initialize(wl_path)
      @wl_file = Fuffa::Utils.get_file(wl_path)
      # ...
    end

    def get_line()
      begin
        @wl_file.readline chomp: true
      rescue EOFError
        nil
      end
    end

  end
end
