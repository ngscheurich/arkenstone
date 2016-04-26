require "thor"

module Arkenstone
  class Forge < Thor
    include Thor::Actions

    BOXES = %w(ubuntu/trusty64).freeze
    PROVIDERS = %w(virtualbox).freeze
    PROVISIONERS = %w(ansible).freeze

    option :box,         type: :string, aliases: "-B", default: "ubuntu/trusty64",
                         desc: "Vagrant base box (options: #{BOXES.join('/')})"

    option :provider,    type: :string, aliases: "-P", default: "virtualbox",
                         desc: "Vagrant VM provider (options: #{PROVIDERS.join('/')})"

    option :provisioner, type: :string, aliases: "-p", default: "ansible",
                         desc: "Vagrant provisioner (options: #{PROVISIONERS.join('/')})"

    desc "new APP_PATH [options]", "Generate a new Rails environment at PATH"
    def new(path)
      @path = path
      vagrant
      provisioner
    end

    private

    def vagrant
      template "Vagrantfile.erb", "#{@path}/Vagrantfile"
    end

    def provisioner
      case options[:provisioner]
      when "ansible"
        directory "ansible", "#{@path}/provision/ansible"
      end
    end
  end
end
