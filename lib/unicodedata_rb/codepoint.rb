# Format of UnicodeData.txt: https://www.unicode.org/L2/L1999/UnicodeData.html

module UnicodedataRb
  CODEPOINT_FIELDS = [
    :codepoint, :name, :category, :combining_class, :bidi_class,
    :decomposition, :digit_value, :non_decimal_digit_value,
    :numeric_value, :bidi_mirrored, :unicode1_name, :iso_comment,
    :simple_uppercase_map, :simple_lowercase_map, :simple_titlecase_map,
  ]

  NUMERIC_FIELDS = [:digit_value, :non_decimal_digit_value, :numeric_value]

  class Codepoint < Struct.new(*UnicodedataRb::CODEPOINT_FIELDS)
    def initialize(*args)
      super
      self.codepoint = self.codepoint.to_i(16)
      NUMERIC_FIELDS.each { |f| send("#{f}=", send(f).to_r) }
    end

    def self.from_line(line)
      new *(line.chomp.split ';')
    end
  end
end
