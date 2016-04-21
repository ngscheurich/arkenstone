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
      template "database.yml.erb", "config/database.yml",
               force: true
    end

    def customize_application_layout
      template "application.html.erb", "app/views/layouts/application.html.erb",
               force: true
    end

    def config_ci
      copy_file "circle.yml", "circle.yml"
    end

    def create_partials_directory
      empty_directory "app/views/application"
    end

    def create_flashes_partial
      copy_file "_flashes.html.erb", "app/views/application/_flashes.html.erb"
    end

    def create_factories_directory
      empty_directory "spec/factories"
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

    def clean_up_ruby_files
      files = `grep '^ *#[^!]' -l -r --include=*.rb .`.split("\n")

      files.each do |file|
        gsub_file file, /^ *#.*\n/, ""
        gsub_file file, /\n$/, ""
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

    def configure_locale
      template "en.yml.erb", "config/locales/en.yml",
               force: true
    end

    def create_home_page
      template "home.html.erb", "app/views/pages/home.html.erb"
      copy_file "high_voltage.rb", "config/initializers/high_voltage.rb"
    end
    
    def create_binstubs
      copy_file "rails", "bin/rails", force: true
      copy_file "rake", "bin/rake", force: true
      copy_file "spring", "bin/spring"
    end

    def create_vagrantfile
      template "Vagrantfile.erb", "Vagrantfile"
    end

    def add_ansible
      git clone: "https://github.com/ngscheurich/ansible-rails.git ansible"
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
