# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "arkenstone/version"

Gem::Specification.new do |spec|
  spec.name          = "arkenstone"
  spec.version       = Arkenstone::VERSION
  spec.license       = "GPL-3.0"
  spec.author        = "Nicholas Scheurich"
  spec.email         = "nick@scheurich.me"

  spec.summary       = "A Rails bootstrapper"
  spec.description   = <<-EOS
The Arkenstone is a Ruby on Rails application generator set up to use my
preferred development configuration. It is heavily influenced by thoughtbot’s
Suspenders; I simply prefer to have something that I’ve pruned from infancy
and just totally *get*, you know?
  EOS
  spec.homepage      = "https://github.com/ngscheurich/arkenstone"

  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = "bin"
  spec.executables   = ["arkenstone"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails", "~>4.2", ">=4.2.0"

  spec.add_development_dependency "bitters", "~> 0.1"
  spec.add_development_dependency "bundler", "~> 1.0"
  spec.add_development_dependency "pry", "~> 0.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
end
