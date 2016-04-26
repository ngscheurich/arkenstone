require "spec_helper"

RSpec.describe "Generating a new project with the VirtualBox provider" do
  before(:example) do
    remove_dummy_app
    run_arkenstone("--provisioner=vagrant")
  end

  it "correctly configures Vagrant" do
    vagrantfile = File.read("#{app_path}/Vagrantfile")

    expect(vagrantfile).to include('config.vm.provider "virtualbox"')
  end
end
