# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ropes/version'

Gem::Specification.new do |spec|
  spec.name          = "ropes"
  spec.version       = Ropes::VERSION
  spec.authors       = ["Andy Sykes"]
  spec.email         = ["github@tinycat.co.uk"]
  spec.description   = %q{Build apt and yum repositories from
                          a directory, or from supplied information}
  spec.summary       = %q{Build apt and yum repositories with Ruby}
  spec.homepage      = "https://github.com/andytinycat/ropes"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "debeasy"
  spec.add_dependency "gpgme"
  spec.add_dependency "arr-pm"
  spec.add_dependency "nokogiri"
end
