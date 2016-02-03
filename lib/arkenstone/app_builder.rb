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

    def set_up_authentication
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

    def set_up_database
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

    def config_travis_ci
      template ".travis.yml.erb", ".travis.yml"
    end

    def create_partials_directory
      empty_directory "app/views/application"
    end

    def create_factories_file
      copy_file "factories.rb", "spec/factories.rb"
    end

    def set_up_rspec
      bundle_command "exec rails generate rspec:install"
    end

    def customize_rails_helper
      remove_file "spec/rails_helper.rb"
      copy_file "rails_helper.rb", "spec/rails_helper.rb"
    end

    def set_up_database_cleaner
      copy_file "database_cleaner.rb", "spec/support/database_cleaner.rb"
    end

    def strip_comments_from_ruby_files
      files = `grep '^ *#[^!]' -l -r --include=*.rb .`.split("\n")

      files.each do |file|
        gsub_file file, /^ *#.*\n/, ""
      end
    end

    def set_up_style_sheets
      remove_file "app/assets/stylesheets/application.css"
      copy_file "application.scss",
                "app/assets/stylesheets/application.scss"
    end

    def set_up_bitters
      run "bitters install --path app/assets/stylesheets"
    end

    def initialize_git_repo
      git :init
    end

    def create_initial_git_commit
      git add: "."
      git commit: "-m 'Initial commit [via Arkenstone]'"
    end

    def create_github_repo
      run "hub create"
      git push: "origin master"
    end
  end
end
