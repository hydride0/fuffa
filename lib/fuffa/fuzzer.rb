class Fuffa
  class Fuzzer
    @fuzz_results
    @wl
    @url

    def initialize(url, wl_path)
      @fuzz_results = []
      @wl = Fuffa::WordList.new(wl_path)
      @url = Fuffa::Url.new(url)
    end

    def fuzz()
      #TODO maybe do this with a timer?
      @fuzz_results = []
      until (new_word = @wl.get_line).nil?
        iter_url = @url.fuzz_with(new_word)
        code = Fuffa::Utils.colorize(Fuffa::Url.get_response_code(iter_url))
        @fuzz_results << {:url => iter_url, :code => code}
      end
    end

    def get_results()
      @fuzz_results
    end
  end
end
