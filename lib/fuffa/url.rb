class Fuffa
  class Url
    def initialize(url, port=80, fuzz_word='FUZZ')
      if URI::regexp =~ url && url.include?(fuzz_word)
        @url = URI(url)
        @fuzz_word = fuzz_word
        @url.port = port if (1024..65535).include?(port)
      #else 
        # raise BadUrlException????
      end
    end

    def fuzz_with(word)
      URI(@url.to_s.gsub(@fuzz_word, word))
    end

    def self.get_response_code(url) 
      response = Net::HTTP.start(url.host).head(url.path)
      if !response.nil?
        response.code
      #else
        # raise NoResponseException????
      end
    end

  end
end
