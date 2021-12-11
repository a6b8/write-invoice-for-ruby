# frozen_string_literal: true

require_relative "lib/write_invoice/version"

Gem::Specification.new do |spec|
  spec.name          = "write_invoice"
  spec.version       = WriteInvoice::VERSION
  spec.authors       = ["a6b8"]
  spec.email         = ["hello@13pus4.com"]

  spec.summary       = "Highly customizable invoice builder for ruby"
  spec.description   = "Highly customizable invoice builder for ruby with bulk and example functions for fast processing."
  spec.homepage      = "https://github.com/a6b8/write-invoice-for-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/a6b8/write-invoice-for-ruby"
  spec.metadata["changelog_uri"] = "https://raw.githubusercontent.com/a6b8/write-invoice-for-ruby/main/CHANGELOG.md"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { | f | File.basename( f ) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_dependency "prawn-table", "~> 0.2.2"
  spec.add_dependency "prawn", "~> 2.4.0"
  # spec.add_dependency "prawn/measurement_extensions", "~> 1.0"
  spec.add_dependency "prawn-qrcode", "~> 0.5.2"
  spec.add_dependency "date", "~> 3.1.0"
  spec.add_dependency "faker", "~> 2.19.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
