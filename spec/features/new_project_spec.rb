require "spec_helper"

RSpec.describe "Generating a new project" do
  before(:example) do
    remove_dummy_app
    run_arkenstone("--skip-bundle")
  end

  it "sets the Ruby version" do
    ruby_version_file = File.join(project_path, ".ruby-version")
    expected_contents = Arkenstone::RUBY_VERSION + "\n"

    expect(File).to exist(ruby_version_file)
    expect(file_contents(ruby_version_file)).to eq(expected_contents)
  end

  it "creates Simple Form files" do
    expect(File).to exist("#{project_path}/config/initializers/simple_form.rb")
    expect(File).to exist("#{project_path}/config/locales/simple_form.en.yml")
    expect(File).to exist("#{project_path}/lib/templates/html/scaffold/_form.html.erb")
  end

  it "customizes the application layout" do
    layout = File.read("#{project_path}/app/views/layouts/application.html.erb")
    expect(layout).to match(/<title><%= page_title %><\/title>/)
    expect(layout).to match(/<body class="<%= body_class %>">/)
  end

  it "initializes a Git repository" do
    git_opts = "--git-dir=#{project_path}/.git"
    git_opts << " --work-tree=#{project_path}"

    expect(`git #{git_opts} log -1`).to match(/Initial commit/)
  end
end
