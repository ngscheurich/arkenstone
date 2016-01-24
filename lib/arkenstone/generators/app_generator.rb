require "rails/generators"
require "rails/generators/rails/app/app_generator"

module Arkenstone
  class AppGenerator < Rails::Generators::AppGenerator
    def finish_template
      arkenstone_customization
      super
    end

    def arkenstone_customization
      build :set_ruby_version
    end

    protected

    def get_builder_class
      Arkenstone::AppBuilder
    end
  end
end
