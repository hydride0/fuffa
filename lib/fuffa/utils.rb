class Fuffa
  class Utils
    SUPPORTED_RESPONSES = ['400','401','403','404','405','500','501','301',
                           '302','303','304','307','200','201','202','204']

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
        code.colorize :red
      when '301', '302', '303', '304', '307'
        code.colorize :yellow
      when '200', '201', '202', '204'
        code.colorize :green
      else
        code
      end
    end

    def self.check_response_codes(codes)
      code_list = codes.delete(' ').split(',').uniq
      if (code_list - SUPPORTED_RESPONSES).empty?
        code_list
      else
        nil
      end
    end
    
  end
end
