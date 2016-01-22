# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "arkenstone/version"

Gem::Specification.new do |spec|
  spec.name          = "arkenstone"
  spec.version       = Arkenstone::VERSION
  spec.authors       = ["Nicholas Scheurich"]
  spec.email         = ["nick@scheurich.me"]

  spec.summary       = "A Rails bootstrapper"
  spec.description   = <<-EOS
A Ruby on Rails application generator using my current most
favorite dev stack. Heavily influenced by Suspenders by thoughtbot;
I just prefer something I have pruned from infancy and totally
understand, like a bonsai tree not afraid to share its feelings.
  EOS
  spec.homepage      = "https://github.com/ngscheurich/arkenstone"

  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = "bin"
  spec.executables   = ["arkenstone"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
end
