require "rails/generators"
require "rails/generators/rails/app/app_generator"

module Arkenstone
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :authentication, type: :boolean, aliases: "-A", default: false,
                 desc: "Create User model and configure authentication"

    class_option :database, type: :string, aliases: "-d", default: "postgresql",
                 desc: "Configure for selected database (options: #{DATABASES.join("/")})"

    class_option :github, type: :boolean, aliases: "-H", default: false,
                 desc: "Create a GitHub repository with the same name as the project"

    def finish_template
      invoke :forge_the_arkenstone
      super
    end

    def forge_the_arkenstone
      build :set_ruby_version
      build :setup_authentication if options[:authentication]
      build :create_simple_form_files
      build :customize_application_layout
      build :setup_database
      build :create_docker_files
      build :config_travis_ci
      build :initialize_git_repo
      build :create_github_repo if options[:github]
    end

    protected

    def get_builder_class
      Arkenstone::AppBuilder
    end
  end
end
