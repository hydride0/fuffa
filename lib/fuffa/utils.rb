class Fuffa
  class Utils
    RED    = ['\e[0;31;49m', '\e[0m']
    YELLOW = ['\e[0;33;49m', '\e[0m']
    GREEN  = ['\e[0;32;49m', '\e[0m']
  
    def self.get_file(wl_path)
      if File.exists?(wl_path) && File.readable?(wl_path)
        File.new(wl_path, 'r', chomp: true)
      # else
        # raise WordListException????
      end
    end

    def self.colorize(code)
      case code
      when '400', '401', '403', '404', '405', '500', '501'
        RED.join(code)
      when '301', '302', '303', '304', '307'
        YELLOW.join(code)
      when '200', '201', '202', '204'
        GREEN.join(code)
      else
        code
      end
    end

    def self.put_table(fuzzer)
      if !fuzzer.results.empty?
        table = Terminal::Table.new headings: ['URL', 'Response'] do |t|
          fuzzer.results.each do |res|
            t << [res[:url], res[:code]]
            t << :separator
          end
        end
        puts table
      else
        puts 'No results.'
      end
    end

  end
end
