# frozen_string_literal: true

require_relative "lib/unicodedata_rb/version"

Gem::Specification.new do |spec|
  spec.name = "unicodedata_rb"
  spec.version = UnicodedataRb::VERSION
  spec.authors = ["bubiche"]
  spec.email = ["bubiche95@gmail.com"]

  spec.summary = "Ruby wrapper for unicode data."
  spec.homepage = "https://github.com/bubiche/unicodedata_rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/bubiche/unicodedata_rb/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
