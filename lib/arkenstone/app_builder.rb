module Arkenstone
  class AppBuilder < Rails::AppBuilder
    def readme
      template "README.md.erb", "README.md"
    end

    def gemfile
      say "Customizing Gemfile..."
      template "Gemfile.erb", "Gemfile"
    end
  end
end
