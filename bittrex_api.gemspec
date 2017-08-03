lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bittrex_api/version'
Gem::Specification.new do |s|
  s.name = 'bittrex_api'
  s.version = BittrexApi::VERSION
  s.date = '2017-08-03'
  s.summary = "Provides a wrapper for bittrex.com api"
  s.description = "Provides a wrapper for bittrex.com api"
  s.authors = ["Bastian Ermann"]
  s.email = "bastian@ermannb.com"
  s.homepage = ""
  s.license = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake", '~> 0'

  s.add_dependency 'rest-client', '~> 0'
  s.add_dependency 'addressable', '~> 0'
end
