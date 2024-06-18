require_relative "unicodedata_rb/codepoint"
require_relative "unicodedata_rb/generate_index"
require_relative "unicodedata_rb/constants"
require_relative "unicodedata_rb/version"

module UnicodedataRb
  def self.codepoint(num)
    UnicodedataRb::Codepoint.from_line _unicodedata_txt_line_from(codepoint: num)
  end

  def self.codepoint_from_char(c)
    UnicodedataRb::Codepoint.from_line _unicodedata_txt_line_from(codepoint: c.ord)
  end

  def self.codepoint_from_name(name)
    UnicodedataRb::Codepoint.from_line _unicodedata_txt_line_from(name:)
  end

  def self._unicodedata_txt_line_from(codepoint: nil, name: nil)
    raise ArgumentError if (codepoint.nil? && name.nil?) || (!codepoint.nil? && !name.nil?)
    _unicodedata_txt_file.rewind
    offset =
      if !codepoint.nil?
        _unicodedata_index[:codepoint][codepoint]
      else
        _unicodedata_index[:name][name]
      end

    raise ArgumentError if offset.nil?

    _unicodedata_txt_file.seek offset
    _unicodedata_txt_file.readline.chomp
  end

  def self._unicodedata_txt_file
    @@_unicodedata_txt_file ||= File.open(UnicodedataRb::Constants::UNICODEDATA_TXT_PATH)
  end

  def self._unicodedata_index
    @@_unicodedata_index ||= Marshal.load(File.binread(UnicodedataRb::Constants::UNICODEDATA_INDEX_PATH))
  end

  def self.generate_index
    UnicodedataRb::GenerateIndex.call
  end
end

