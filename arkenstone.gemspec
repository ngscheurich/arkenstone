# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "arkenstone/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= #{Arkenstone::RUBY_VERSION}"

  spec.name          = "arkenstone"
  spec.version       = Arkenstone::VERSION
  spec.license       = "MIT"
  spec.author        = "Nicholas Scheurich"
  spec.email         = "nick@scheurich.me"

  spec.summary       = "A Rails development environment generator"
  spec.description   = <<-DESC
The Arkenstone is a Ruby on Rails development environment generator.
Its goal is to provide an easy way to spin up a new Vagrant box provisioned for Rails development.
DESC
  spec.homepage      = "https://github.com/ngscheurich/arkenstone"

  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = "bin"
  spec.executables   = ["arkenstone"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "codecov", "~> 0"
  spec.add_development_dependency "pry", "~> 0.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "rspec_junit_formatter", "0.2.2"
  spec.add_development_dependency "thor", "~> 0"
end
