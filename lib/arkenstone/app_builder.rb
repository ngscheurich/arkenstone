module Arkenstone
  class AppBuilder < Rails::AppBuilder
    def gemfile
      template "Gemfile.erb", "Gemfile"
    end

    def readme
      template "README.md.erb", "README.md"
    end

    def set_ruby_version
      create_file ".ruby-version", "#{Arkenstone::RUBY_VERSION}\n"
    end

    def setup_authentication
      template "user.rb", "app/models/user.rb"
      inject_into_file(
        "app/controllers/application_controller.rb",
        "  include Clearance::Controller\n\n",
        after: "class ApplicationController < ActionController::Base"
      )
    end

    def create_simple_form_files
      copy_file "simple_form.rb", "config/initializers/simple_form.rb"
      copy_file "simple_form.en.yml", "config/locales/simple_form.en.yml"
      copy_file "_form.html.erb", "lib/templates/html/scaffold/_form.html.erb"
    end

    def setup_database
      template "postgresql_database.yml.erb", "config/database.yml",
               force: true
    end

    def customize_application_layout
      template "application.html.erb", "app/views/layouts/application.html.erb",
               force: true
    end

    def create_database
      bundle_command "exec rake db:create db:migrate"
    end

    def create_docker_files
      template "Dockerfile.erb", "Dockerfile"
      copy_file "docker-compose.yml"
    end

    def initialize_git_repo
      git :init
      git add: "."
      git commit: "-m 'Initial commit [via Arkenstone]'"
    end

    def create_github_repo
      run "hub create"
      git push: "origin master"
    end
  end
end
