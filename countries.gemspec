# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'countries/version'

Gem::Specification.new do |spec|
  spec.name          = "countries"
  spec.version       = Countries::VERSION
  spec.authors       = ["Hafizur Rahman"]
  spec.email         = ["hafizur.rahmanc@gmail.com"]

  spec.summary       = %q{Countries cli-Gem using restcountries.eu API}
  spec.description   = %q{Getting information about countries using RESTful API http://restcountries.eu}
  spec.homepage      = "https://github.com/hafizrahman1/countries"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "'https://rubygems.org'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"


  spec.add_dependency "json"
  spec.add_dependency "rest-client"
  spec.add_dependency "money"
  spec.add_dependency "i18n_data"
  spec.add_dependency "colorize"



end
