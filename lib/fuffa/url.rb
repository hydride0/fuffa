class Fuffa
  class Url
    @url

    def initialize(url)
      if (URI::regexp =~ url) && (url.include? "FUZZ")
        @url = URI(url)
      #else 
        # raise BadUrlException????
      end
    end

    def fuzz_with(fuzz_word)
      URI(@url.to_s.gsub("FUZZ", fuzz_word))
    end

    def self.get_response_code(url) 
      response = nil
      Net::HTTP.start(url.host, 80) {|http|
        response = http.head(url.path)
      }
      if !response.nil?
        response.code
      #else
        # raise NoResponseException????
      end
    end

  end
end
