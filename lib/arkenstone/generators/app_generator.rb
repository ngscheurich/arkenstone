require "rails/generators"
require "rails/generators/rails/app/app_generator"

module Arkenstone
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :authentication, type: :boolean, aliases: "-A", default: false,
                 desc: "Create User model and configure authentication"

    class_option :github, type: :boolean, aliases: "-H", default: false,
                 desc: "Create a GitHub repository with the same name as the project"

    def finish_template
      build :set_ruby_version
      build :authentication if options[:authentication]
      build :simple_form_install
      build :git_init
      build :github if options[:github]
      super
    end

    def run_after_bundle_callbacks
      super
    end

    protected

    def get_builder_class
      Arkenstone::AppBuilder
    end
  end
end
