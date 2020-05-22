class Fuffa
  class Utils
    def self.get_file(wl_path)
      if (File.exists? wl_path) && (File.readable? wl_path)
        File.new(wl_path, "r", chomp: true)
      # else
        # raise WordListException????
      end
    end

    def self.colorize(code)
      case code
      when "400", "401", "403", "404", "405", "500", "501"
        code.colorize :red
      when "301", "302", "303", "304", "307"
        code.colorize :yellow
      when "200", "201", "202", "204"
        code.colorize :green
      else
        code
      end
    end

    def self.put_table(fuzzer)
      if !fuzzer.get_results.empty?
        table = Terminal::Table.new :headings => ['URL', 'Response'] do |t|
          fuzzer.get_results.each do |res|
            t << [res[:url], res[:code]]
            t << :separator
          end
        end
        puts table
      else
        puts "No results."
      end
    end

  end
end
