require "spec_helper"

RSpec.describe "Generating a new project with the Ansible provisioner" do
  before(:example) do
    remove_dummy_app
    run_arkenstone("--provisioner=ansible")
  end

  it "correctly configures Vagrant" do
    vagrantfile = File.read("#{app_path}/Vagrantfile")

    expect(vagrantfile).to include('config.vm.provision "ansible"')
  end

  it "copies the ansible directory" do
    ansible_dir = "#{app_path}/prov/ansible"

    expect(File).to exist(ansible_dir)
  end
end
