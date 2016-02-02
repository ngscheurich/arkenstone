module Arkenstone
  class AppBuilder < Rails::AppBuilder
    def readme
      template "README.md.erb", "README.md"
    end

    def gemfile
      template "Gemfile.erb", "Gemfile"
    end

    def set_ruby_version
      create_file ".ruby-version", "#{Arkenstone::RUBY_VERSION}\n"
    end

    def authentication
      template "app/models/user.rb"
      include_clearance_controller
    end

    def simple_form_install
      generate "simple_form:install"
    end

    def git_init
      git :init
      git add: "."
      git commit: "-m 'Initial commit [via Arkenstone]'"
    end

    def github
      `hub create`
      git push: "origin master"
    end

    private

    def include_clearance_controller
      path = "app/controllers/application_controller.rb"
      contents = []
      File.open(path) { |f| contents = f.readlines }
      File.open(path, "w+") do |file|
        contents.insert(1, "  include Clearance::Controller\n\n")
        file.write(contents.join)
      end
    end
  end
end
