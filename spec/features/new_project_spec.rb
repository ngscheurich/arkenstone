require "spec_helper"

RSpec.describe "Generating a new project" do
  before(:all) do
    remove_dummy_app
  end

  context "without running `bundle install`" do
    before(:all) do
      run_arkenstone("-B")
    end

    it "creates the .ruby-version file" do
      ruby_version_file = File.join(project_path, ".ruby-version")

      expect(File.exist?(ruby_version_file)).to be true
      expect(File.open(ruby_version_file) { |f| f.read }).to eq(Arkenstone::RUBY_VERSION)
    end
  end
end
