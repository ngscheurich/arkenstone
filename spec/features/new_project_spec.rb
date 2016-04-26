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

  it "forwards the default Rails server port" do
    vagrantfile = File.read("#{app_path}/Vagrantfile")
    config_string = 'config.vm.network "forwarded_port", guest: 3000, host: 3001'
    
    expect(vagrantfile).to include(config_string)
  end

  it "creates the provisioners directory" do
    provisioners_dir = "#{app_path}/provisioners/ansible"

    expect(File).to exist(provisioners_dir)
  end
end
