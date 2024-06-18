# frozen_string_literal: true

RSpec.describe UnicodedataRb do
  it "can query codepoint by character" do
    expect(UnicodedataRb.codepoint_from_char("n").name).to eq("LATIN SMALL LETTER N")
  end

  it "can query codepoint by name" do
    expect(UnicodedataRb.codepoint_from_name("LATIN CAPITAL LETTER I WITH DIAERESIS").codepoint).to eq(207)
  end

  it "can query codepoint by code value" do
    expect(UnicodedataRb.codepoint(0x00D4).name).to eq("LATIN CAPITAL LETTER O WITH CIRCUMFLEX")
  end
end
