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
      include_clearance_controller
    end

    def simple_form_install
      run "rails generate simple_form:install"
    end

    private

    def include_clearance_controller
      path = "app/controllers/application_controller.rb"
      contents = []
      File.open(path) { |f| contents = f.readlines }
      File.open(path, "w+") do |file|
        contents.insert(1, "  include Clearance::Controller\n\n")
        file.write(contents.join)
      end
    end
  end
end
