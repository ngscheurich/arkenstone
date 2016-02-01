require "spec_helper"

RSpec.describe "Generating a new project with authentication" do
  before(:example) do
    remove_dummy_app
    run_arkenstone("--skip-bundle --authentication")
  end

  it "creates a User model" do
    user_model = File.join(models_path, "user.rb")

    expect(File.exist?(user_model)).to be true
  end

  it "adds Clearance::Controller to ApplicationController" do
    application_controller = File.join(controllers_path, "application_controller.rb")
    pattern = /include Clearance::Controller/
    match = nil

    File.open(application_controller) { |f| match = pattern.match(f.read) }

    expect(match).to_not be nil
  end
end
