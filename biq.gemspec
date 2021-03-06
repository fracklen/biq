# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'biq/version'

Gem::Specification.new do |spec|
  spec.name          = 'biq'
  spec.version       = Biq::VERSION
  spec.authors       = ['Martin Neiiendam']
  spec.email         = ['fracklen@gmail.com']

  spec.summary       = 'Client for BiQ.'
  spec.description   = 'Client for fetching BiQ company data.'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'fakeweb'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'faraday'
  spec.add_dependency 'excon'
  spec.add_dependency 'activesupport'
end
