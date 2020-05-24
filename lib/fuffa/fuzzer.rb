class Fuffa
  class Fuzzer
    attr_reader :results
    
    def initialize(opt)
      @results = []
      @wl = Fuffa::WordList.new(opt[:wordlist})
      @url = Fuffa::Url.new(opt[:url], opt[:port], opt[:fuzz_word])
      @output = opt[:output]
      @exclude_resp = opt[:exclude]
    end

    def fuzz()
      @results = []
      while (new_word = @wl.get_line)
        iter_url = @url.fuzz_with(new_word)
        code = Fuffa::Url.get_response_code(iterl_url)
        unless @exclude_resp.include? code
          code = Fuffa::Utils.colorize(code)
          @results << {url: iter_url, code: code}
        end
      end
    end

  end
end
