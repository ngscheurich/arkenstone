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
      template "user.rb", "app/models/user.rb"
      inject_into_file(
        "app/controllers/application_controller.rb",
        "  include Clearance::Controller\n\n",
        after: "class ApplicationController < ActionController::Base"
      )
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
  end
end
