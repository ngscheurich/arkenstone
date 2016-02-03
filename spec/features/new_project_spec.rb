require "spec_helper"

RSpec.describe "Generating a new project" do
  before(:example) do
    remove_dummy_app
    run_arkenstone("--skip-bundle")
  end

  it "sets the Ruby version" do
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
    db_config_regexps = [
      /^development: &default$/,
      /^ +adapter: postgresql$/
    ]

    db_config_regexps.each do |regexp|
      expect(db_config).to match(regexp)
    end
  end

  it "customizes the application layout" do
    layout = File.read("#{project_path}/app/views/layouts/application.html.erb")
    layout_regexps = [
      /^ +<title><%= page_title %><\/title>$/,
      /^ +<body class="<%= body_class %>">$/
    ]

    layout_regexps.each do |regexp|
      expect(layout).to match(regexp)
    end
  end

  it "creates Docker files" do
    dockerfile = File.read("#{project_path}/Dockerfile")
    dockerfile_regexp = /^FROM ruby:#{Arkenstone::RUBY_VERSION}$/
    docker_compose_config = "#{project_path}/docker-compose.yml"

    expect(dockerfile).to match(dockerfile_regexp)
    expect(File).to exist(docker_compose_config)
  end

  it "configures Travis CI" do
    travis_config = File.read("#{project_path}/.travis.yml")
    travis_config_regexp = /^ +- #{Arkenstone::RUBY_VERSION}/

    expect(travis_config).to match(travis_config_regexp)
  end

  it "create the partials directory" do
    partials_dir = "#{project_path}/app/views/application"

    expect(File).to exist(partials_dir)
  end

  it "sets up Rspec" do
    spec_dir = "#{project_path}/spec"

    expect(File).to exist(spec_dir)
  end

  it "initializes a Git repository" do
    git_opts = "--git-dir=#{project_path}/.git"
    git_opts << " --work-tree=#{project_path}"
    git_log = `git #{git_opts} log -1`

    expect(git_log).to include("Initial commit")
  end
end
