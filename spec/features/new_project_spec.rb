require "spec_helper"

RSpec.describe "Generating a new project" do
  before(:example) do
    remove_dummy_app
    run_arkenstone("--skip-bundle")
  end

  it "creates a .ruby-version file" do
    ruby_version_file = File.join(project_path, ".ruby-version")
    expected_contents = Arkenstone::RUBY_VERSION + "\n"

    expect(File.exist?(ruby_version_file)).to be true
    expect(file_contents(ruby_version_file)).to eq(expected_contents)
  end

  it "installs Simple Form" do
    simple_form_initializer = File.join(config_path, "/initializers/simple_form.rb")
    simple_form_locale = File.join(config_path, "/locales/simple_form.en.yml")
    simple_form_partial = File.join(lib_path, "/templates/html/scaffold/_form.html.erb")

    expect(File.exist?(simple_form_initializer)).to be true
    expect(File.exist?(simple_form_locale)).to be true
    expect(File.exist?(simple_form_partial)).to be true
  end

  it "automatically adds all files to local Git repo and makes an initial commit" do
    `git config user.email "test@ci.org"`
    `git config user.name "CI Tester"`
    git_opts = "--git-dir=#{project_path}/.git"
    git_opts << " --work-tree=#{project_path}"

    expect(`git #{git_opts} log -1`).to match(/Initial commit/)
  end
end
