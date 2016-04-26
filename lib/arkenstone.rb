require "arkenstone/version"
require "arkenstone/forge"

begin
  require "pry"
rescue LoadError
  puts "Pry is not installed; debugging via `binding.pry` will not be available."
end

module Arkenstone
end
