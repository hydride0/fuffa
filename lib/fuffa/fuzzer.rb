class Fuffa
  class Fuzzer

    def initialize(opt)
      @results = []
      @wl = Fuffa::WordList.new(opt[:wordlist])
      @url = Fuffa::Url.new(opt[:url], opt[:port], opt[:fuzz_word])
      @json_path = opt[:json]
      @exclude_resp = opt[:exclude]
      @verbose = opt[:verbose]
    end

    def fuzz()
      @results = []
      while (new_word = @wl.get_line)
        iter_url = @url.fuzz_with(new_word)
        begin
          code = Fuffa::Url.get_response_code(iter_url)
        rescue Errno::ECONNREFUSED
          abort("Connection refused")
        rescue Net::OpenTimeout
          puts "'#{iter_url}' timed out."
          next
        end
        unless @exclude_resp.include? code
          @results << {url: iter_url, code: code}
          put_result(iter_url, code) if @verbose
        end
      end
      write_json(@json_path) unless @json_path.empty?
    end

    private
    
    def put_result(url, code)
      puts "#{url.to_s} #{Fuffa::Utils.colorize(code)}\n"
    end

    def write_json(path)
      File.write(path, @results.to_json)
      rescue Errno::EPERM
        abort "Couldn't write to file. Check permissions"
      else
        puts "Written JSON to #{path}"
    end

  end
end
