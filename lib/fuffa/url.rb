class Fuffa
  class Url
    def initialize(url, port=80)
      if URI::regexp =~ url && url.include?('FUZZ')
        @url = URI(url)
        
        @url.port = port if (1024..65535).include?(port)
      #else 
        # raise BadUrlException????
      end
    end

    def fuzz_with(fuzz_word)
      URI(@url.to_s.gsub('FUZZ', fuzz_word))
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
