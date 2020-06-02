class Fuffa
  class Fuzzer
    
    def initialize(opt)
      @results = []
      @wl = Fuffa::WordList.new(opt[:wordlist])
      @path = opt[:wordlist]
      @url = Fuffa::Url.new(opt[:url], opt[:port], opt[:fuzz_word])
      @json_path = opt[:json]
      @exclude_resp = opt[:exclude]
      @verbose = opt[:verbose]
      @n_thr = opt[:threads]
    end

    def fuzz()
      @results = []
      m = Mutex.new
      # forgive me
      n_lines = `wc -l #{@path}`.to_i
      lines_per_th = [].tap{ |a| @n_thr.times { a << (n_lines/@n_thr).to_i } }
      lines_per_th[@n_thr-1] += n_lines % @n_thr
      tasks = []
      @n_thr.times do |th|
        tasks[th] = Thread.new do
          words = @wl.get_n_lines(lines_per_th[th])
          words.each do |new_word|
            iter_url = @url.fuzz_with(new_word)
            begin
              code = Fuffa::Url.get_response_code(iter_url)
            rescue Errno::ECONNREFUSED
              abort('Connection refused')
            rescue Net::OpenTimeout
              puts "'#{iter_url}' timed out."
              next
            rescue Errno::EHOSTUNREACH
              puts "'#{iter_url}' unreachable."
              next
            end
            unless @exclude_resp.include? code
              m.synchronize { @results << {url: iter_url, code: code} }
              put_result(iter_url, code) if @verbose
            end
          end
        end
      end
      tasks.each { |t| t.join }
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
