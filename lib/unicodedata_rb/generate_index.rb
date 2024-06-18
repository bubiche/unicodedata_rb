# Download data and build indices
# Inspired by https://github.com/runpaint/unicode-data
require "logger"
require "net/http"
require_relative "codepoint"
require_relative "constants"


module UnicodedataRb
  class GenerateIndex
    def self.call(...)
      new(...).call
    end

    attr_reader :logger
    def initialize(logger: Logger.new(STDOUT))
      @logger = logger
    end
    private_class_method :new

    def call
      download_file("#{unicodedata_url_prefix}UnicodeData.txt", UnicodedataRb::Constants::UNICODEDATA_TXT_PATH)

      # Format of UnicodeData.txt: https://www.unicode.org/L2/L1999/UnicodeData.html
      File.open(UnicodedataRb::Constants::UNICODEDATA_TXT_PATH) do |f|
        codepoint_index = {}
        name_index = {}

        f.each_line do |line|
          start_line_pos = f.pos - line.size
          codepoint = UnicodedataRb::Codepoint.from_line(line)
          codepoint_index[codepoint.codepoint] = start_line_pos
          name_index[codepoint.name] = start_line_pos
        end

        index = {
          codepoint: codepoint_index,
          name: name_index
        }
        File.open(UnicodedataRb::Constants::UNICODEDATA_INDEX_PATH, 'wb') { |f| Marshal.dump(index, f) }
      end
    end

    def download_file(url, save_path)
      logger.info("Downloading #{url}")
      uri = URI(url)

      Net::HTTP.start(uri.host, :use_ssl => true) do |http|
        request = Net::HTTP::Get.new uri

        http.request request do |response|
          open save_path, "w:UTF-8" do |io|
            response.read_body do |chunk|
              io.write chunk
            end
          end
        end
      end
    end

    def unicodedata_url_prefix
      @unicodedata_url_prefix ||= "https://unicode.org/Public/#{RbConfig::CONFIG["UNICODE_VERSION"]}/ucd/"
    end
  end
end
