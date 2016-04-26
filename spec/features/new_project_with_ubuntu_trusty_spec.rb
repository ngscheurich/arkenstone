require "spec_helper"

RSpec.describe "Generating a new project with a 64-bit Ubuntu 14.04 box" do
  before(:example) do
    remove_dummy_app
    run_arkenstone("--box=ubuntu/trusty64")
  end

  it "correctly configures Vagrant" do
    vagrantfile = File.read("#{app_path}/Vagrantfile")

    expect(vagrantfile).to include('config.vm.box = "ubuntu/trusty64"')
  end
end
