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
      copy_file "simple_form.rb", "config/initializers/simple_form.rb"
      copy_file "simple_form.en.yml", "config/locales/simple_form.en.yml"
      copy_file "_form.html.erb", "lib/templates/html/scaffold/_form.html.erb"
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
