require "spec_helper"

RSpec.describe "Generating a new project" do
  before(:example) do
    remove_dummy_app
    run_arkenstone("--skip-bundle")
  end

  it "sets Ruby version" do
    ruby_version_file = File.read("#{project_path}/.ruby-version")
    ruby_version_regexp = /^#{Arkenstone::RUBY_VERSION}\n/

    expect(ruby_version_file).to match(ruby_version_regexp)
  end

  it "creates Simple Form files" do
    simple_form_initializer = "#{project_path}/config/initializers/simple_form.rb"
    simple_form_locale = "#{project_path}/config/locales/simple_form.en.yml"
    simple_form_partial = "#{project_path}/lib/templates/html/scaffold/_form.html.erb"

    expect(File).to exist(simple_form_initializer)
    expect(File).to exist(simple_form_locale)
    expect(File).to exist(simple_form_partial)
  end

  it "sets up the database" do
    db_config = File.read("#{project_path}/config/database.yml")

    expect(db_config).to include("adapter: postgresql")
    expect(db_config).to include("database: #{app_name}_development")
  end

  it "customizes application layout" do
    layout = File.read("#{project_path}/app/views/layouts/application.html.erb")
    layout_regexps = [
      /^ +<title><%= page_title %><\/title>$/,
      /^ +<body class="<%= body_class %>">$/
    ]

    layout_regexps.each do |regexp|
      expect(layout).to match(regexp)
    end
  end

  it "configures CircleCI" do
    circleci_config = "#{project_path}/circle.yml"

    expect(File).to exist(circleci_config)
  end

  it "creates factories directory" do
    factories_dir = "#{project_path}/spec/factories"

    expect(File).to exist(factories_dir)
  end

  it "creates partials directory" do
    partials_dir = "#{project_path}/app/views/application"

    expect(File).to exist(partials_dir)
  end

  it "creates flashes partial" do
    flashes = "#{project_path}/app/views/application/_flashes.html.erb"

    expect(File).to exist(flashes)
  end

  it "sets up RSpec" do
    spec_dir = "#{project_path}/spec"

    expect(File).to exist(spec_dir)
  end

  it "customizes rails_helper.rb" do
    rails_helper = File.read("#{project_path}/spec/rails_helper.rb")

    expect(rails_helper).to include('Rails.root.join("spec/support/**/*.rb")')
    expect(rails_helper).to include("config.use_transactional_fixtures = false")
    expect(rails_helper).to include("config.include Features, type: :feature")
  end

  it "sets up Database Cleaner" do
    database_cleaner_file = "#{project_path}/spec/support/database_cleaner.rb"

    expect(File).to exist(database_cleaner_file)
  end

  it "strips comments from Ruby files" do
    result = `grep '^ *#[^!]' -l -r --include=*.rb #{project_path}`

    expect(result).to eq("")
  end

  it "sets up style sheets" do
    application_css = "#{project_path}/app/assets/stylesheets/application.css"
    application_scss = "#{project_path}/app/assets/stylesheets/application.scss"

    expect(File).to_not exist(application_css)
    expect(File).to exist(application_scss)
  end

  it "sets up Bitters" do
    bitters_dir = "#{project_path}/app/assets/stylesheets/base/_base.scss"
    expect(File).to exist(bitters_dir)
  end

  it "configures locale" do
    en_locale = File.read("#{project_path}/config/locales/en.yml")

    expect(en_locale).to include("application: Arkenstone Test")
  end

  it "sets home page as root path" do
    home_page = "#{project_path}/app/views/pages/home.html.erb"
    high_voltage_initializer = File.read("#{project_path}/config/initializers/high_voltage.rb")

    expect(File).to exist(home_page)
    expect(high_voltage_initializer).to include('config.home_page = "home"')
  end

  it "initializes a Git repository" do
    git_dir = "#{project_path}/.git"

    expect(File).to exist(git_dir)
  end

  it "creates an initial Git commit" do
    git_opts = "--git-dir=#{project_path}/.git"
    git_opts << " --work-tree=#{project_path}"
    git_log = `git #{git_opts} log -1`

    expect(git_log).to include("Initial commit")
  end
end
