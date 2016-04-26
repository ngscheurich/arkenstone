require "spec_helper"

RSpec.describe "Generating a new project" do
  before(:example) do
    remove_dummy_app
    run_arkenstone
  end

  it "creates a Vagrantfile" do
    vagrantfile = "#{app_path}/Vagrantfile"

    expect(File).to exist(vagrantfile)
  end

  it "creates the provisioners directory" do
    provisioners_dir = "#{app_path}/provisioners/ansible"

    expect(File).to exist(provisioners_dir)
  end
end
