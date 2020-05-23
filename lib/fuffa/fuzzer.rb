class Fuffa
  class Fuzzer
    attr_reader :results
    
    def initialize(url, port, wl_path)
      @results = []
      @wl = Fuffa::WordList.new(wl_path)
      @url = Fuffa::Url.new(url, port)
    end

    def fuzz()
      @results = []
      while (new_word = @wl.get_line)
        iter_url = @url.fuzz_with(new_word)
        code = Fuffa::Utils.colorize(Fuffa::Url.get_response_code(iter_url))
        @results << {url: iter_url, code: code}
      end
    end

  end
end
