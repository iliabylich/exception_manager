# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exception_manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'exception_manager'
  spec.version       = ExceptionManager::Version::STRING
  spec.authors       = ['Ilya Bylich']
  spec.email         = ['ibylich@gmail.com']
  spec.summary       = 'Tool for managing exceptions'
  spec.description   = %q{Gem for inspecting local and class/instance variables when raising exceptions}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'rspec-its', '~> 1.2.0'
end
