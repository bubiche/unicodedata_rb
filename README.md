# UnicodedataRb

Ruby wrapper for unicode data.

## Installation

    $ gem install unicodedata_rb

## Usage

The gem already came with `UnicodeData.txt` version 15.1.0 predownloaded. If you want to redownload a version based on your ruby installation (configured with `RbConfig::CONFIG["UNICODE_VERSION"]`), run `UnicodedataRb.generate_index`.

```ruby
codepoint = UnicodedataRb.codepoint_from_char("n")
# codepoint field names are codepoint, name, category, combining_class, bidi_class, decomposition, digit_value, non_decimal_digit_value, numeric_value, bidi_mirrored, unicode1_name, iso_comment, simple_uppercase_map, simple_lowercase_map, simple_titlecase_map.

puts codepoint.name # should print LATIN SMALL LETTER N

# can also query by code value or name
UnicodedataRb.codepoint_from_name("RIGHT CURLY BRACKET")
UnicodedataRb.codepoint(214) # or UnicodedataRb.codepoint(0x00D6)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/unicodedata_rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
