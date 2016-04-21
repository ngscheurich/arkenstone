require "rails/generators"
require "rails/generators/rails/app/app_generator"

module Arkenstone
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :skip_test, type: :boolean, aliases: "-T", default: true,
                 desc: "Skip test files"

    class_option :authentication, type: :boolean, aliases: "-A", default: false,
                 desc: "Create User model and configure authentication"

    class_option :database, type: :string, aliases: "-d", default: "postgresql",
                 desc: "Configure for selected database (options: #{DATABASES.join('/')})"

    class_option :github, type: :boolean, aliases: "-H", default: false,
                 desc: "Create a GitHub repository with the same name as the project"

    def finish_template
      invoke :forge_the_arkenstone
      super
    end

    def forge_the_arkenstone
      build :set_ruby_version
      build :set_up_authentication if options[:authentication]
      build :create_simple_form_files
      build :customize_application_layout
      build :set_up_database
      build :config_ci
      build :create_factories_directory
      build :create_partials_directory
      build :create_flashes_partial
      build :set_up_rspec
      build :customize_rails_helper
      build :set_up_database_cleaner
      build :clean_up_ruby_files
      build :set_up_style_sheets
      build :set_up_bitters
      build :configure_locale
      build :create_home_page
      build :create_binstubs
      build :initialize_git_repo
      build :create_initial_git_commit
      build :create_github_repo if options[:github]
    end

    protected

    def get_builder_class
      Arkenstone::AppBuilder
    end
  end
end
