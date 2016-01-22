require "rails/generators"
require "rails/generators/rails/app/app_generator"

module Arkenstone
  class AppGenerator < Rails::Generators::AppGenerator
    def get_builder_class
      Arkenstone::AppBuilder
    end
  end
end
