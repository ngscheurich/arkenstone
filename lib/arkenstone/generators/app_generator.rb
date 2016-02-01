require "rails/generators"
require "rails/generators/rails/app/app_generator"

module Arkenstone
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :authentication, type: :boolean, aliases: "-A", default: false,
                 desc: "Create User model and configure authentication"

    def finish_template
      build :set_ruby_version
      build :authentication if options[:authentication]
      super
    end

    def run_after_bundle_callbacks
      build :simple_form_install
      super
    end

    protected

    def get_builder_class
      Arkenstone::AppBuilder
    end
  end
end
