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

  it "automatically adds all files to local Git repo and makes an initial commit" do
    git_opts = "--git-dir=#{project_path}/.git"
    git_opts << " --work-tree=#{project_path}"

    expect(`git #{git_opts} log -1`).to match(/Initial commit/)
  end
end
