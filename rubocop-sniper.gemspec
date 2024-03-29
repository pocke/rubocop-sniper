# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop/sniper/version'

Gem::Specification.new do |spec|
  spec.name          = "rubocop-sniper"
  spec.version       = RuboCop::Sniper::VERSION
  spec.authors       = ["Masataka Kuwabara"]
  spec.email         = ["p.ck.t22@gmail.com"]

  spec.summary       = %q{}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/pocke/rubocop-sniper"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rubocop', '>= 0.46.0'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
