# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openssl/better_defaults/version'

Gem::Specification.new do |spec|
  spec.name          = "openssl-better_defaults"
  spec.version       = Openssl::BetterDefaults::VERSION
  spec.authors       = ["Marie Markwell"]
  spec.email         = ["me@marie.so"]
  spec.summary       = %q{More secure OpenSSL defaults for Ruby.}
  spec.description   = spec.description
  spec.homepage      = "https://gitlab.com/duckinator/openssl-better_defaults"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
