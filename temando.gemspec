# -*- encoding: utf-8 -*-
require File.expand_path('../lib/temando/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jason Stirk"]
  gem.email         = ["jason@reinteractive.net"]
  gem.description   = %q{Ruby API to Temando - an Australian transport fulfilment broker}
  gem.summary       = %q{Ruby API to Temando - an Australian transport fulfilment broker}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "temando"
  gem.require_paths = ["lib"]
  gem.version       = Temando::VERSION

  gem.add_dependency 'nokogiri'
  gem.add_dependency 'typhoeus', '~> 0.4.2'

  gem.add_development_dependency 'activesupport'
  gem.add_development_dependency 'rspec', '~> 2.11.0'
  gem.add_development_dependency 'faker'
end
