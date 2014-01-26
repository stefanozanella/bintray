# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'pathname'
require 'bintray/version'

signing_key_file = ENV['RUBYGEMS_SIGNING_KEY_FILE']

Gem::Specification.new do |spec|
  spec.name          = "bintray"
  spec.version       = Bintray::VERSION
  spec.authors       = ["Stefano Zanella"]
  spec.email         = ["zanella.stefano@gmail.com"]
  spec.summary       = %q{A Ruby interface to the Bintray API.}
  spec.homepage      = "https://github.com/stefanozanella/bintray"
  spec.license       = "MIT"
  spec.description   = <<-EOS
    This gem provides a Ruby interface to the Bintray API, plus a Rake task to
    help uploading and publishing packages to Bintray.
  EOS

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubygems-tasks"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "webmock"

  spec.signing_key = Pathname.new(signing_key_file).expand_path if signing_key_file
  spec.cert_chain = ["rubygems-stefanozanella.crt"]
end
