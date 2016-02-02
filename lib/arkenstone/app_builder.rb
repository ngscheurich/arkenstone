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
      template "app/models/user.rb"
      include_clearance_controller
    end

    def simple_form_install
      template "config/initializers/simple_form.rb"
      template "config/locales/simple_form.en.yml"
      form_path = "lib/templates/html/scaffold/_form.html.erb"
      create_file form_path, File.read("#{GEM_PATH}/lib/arkenstone/templates/#{form_path}")
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
