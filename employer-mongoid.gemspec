# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'employer-mongoid/version'

Gem::Specification.new do |gem|
  gem.name          = "employer-mongoid"
  gem.version       = Employer::Mongoid::VERSION
  gem.authors       = ["Mark Kremer"]
  gem.email         = ["mark@without-brains.net"]
  gem.summary       = %q{Mongoid backend for Employer}
  gem.homepage      = "https://github.com/mkremer/employer-mongoid"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "mongoid", "~> 3.0"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry"
end
